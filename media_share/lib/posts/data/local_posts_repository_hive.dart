import 'dart:async';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:media_share/posts/data/posts_repository_firebase.dart';

import '../domain/models/post.dart';

class LocalPostsRepositoryHive {

  //singleton
  static final LocalPostsRepositoryHive _singleton = LocalPostsRepositoryHive
      ._internal();

  LocalPostsRepositoryHive._internal();

  static LocalPostsRepositoryHive get instance => _singleton;


  final PostsRepositoryFirebase _repository = PostsRepositoryFirebase();

  late Box<Map<dynamic, dynamic>> _postsBox;
  late Box<Uint8List> _mediaBox;

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  StreamController<List<Post>> _postsLocalStream = StreamController<
      List<Post>>.broadcast();


  void clearCache() async{
    await _mediaBox.clear();
  }
  Future<void> init() async {
    _postsBox = await Hive.openBox<Map>('posts');
    _mediaBox = await Hive.openBox<Uint8List>('media');

    _repository.postsStream.listen((posts) async{

      await updatePosts(posts);
      _postsLocalStream.add(getPosts());
      print(_mediaBox.length);

    });

    _isInitialized = true;
  }

  Stream<List<Post>> get postsLocalStream => _postsLocalStream.stream;


  Post getPost(String postId) {
    bool exists = _postsBox.containsKey(postId);
    return !exists?Post.unknown(): Post.fromJson(_postsBox.get(postId)!.cast<String, dynamic>()) ;
  }
  List<Post> getPosts() {
    return _postsBox.values
        .map(
            (map) {
          return Post.fromJson(map.cast<String, dynamic>());
        }).toList();
  }

  List<Post> getDeletedPosts(
      {required List<Post> newPosts, required List<Post> oldPosts}) {
    List<Post> deletedPosts = [];
    List<String> newPostIds = newPosts.map((post) => post.postId).toList();
    oldPosts.forEach((oldPost) {
      if (!newPostIds.contains(oldPost.postId)) {
        deletedPosts.add(oldPost);
      }
    });
    return deletedPosts;
  }

  Uint8List? getMedia(String url) {
    return _mediaBox.get(url);
  }

  bool mediaExists(String url) {
    return _mediaBox.containsKey(url);
  }

  Future<void> downloadMedia(String url) async {
    Uint8List? mediaData = await _repository.downloadMedia(url);
    if(mediaData==null){
      return;//failed to fetch media
    }else{
    await _mediaBox.put(url, mediaData);
    }

  }

  Future<void> putMedia(String url, Uint8List data) async {
    await _mediaBox.put(url, data);
  }

  Future<void> onDeletePost(Post post) async {
    await _mediaBox.delete(post.mediaUrl);
    await _mediaBox.delete(post.thumbnailUrl);
  }

  Future<void> updatePosts(List<Post> newPosts) async {
    List<Post> oldPosts = getPosts();
    List<Post> deletedPosts = getDeletedPosts(
        newPosts: newPosts, oldPosts: oldPosts);
    deletedPosts.forEach((post) {
      onDeletePost(post);
    });

    Map<String, Map<String, dynamic>> newPostsJson = {};


    newPosts.forEach((post) {
      newPostsJson[post.postId] = post.toJson();
    });
    await _postsBox.clear();
    await _postsBox.putAll(newPostsJson);
  }
}
