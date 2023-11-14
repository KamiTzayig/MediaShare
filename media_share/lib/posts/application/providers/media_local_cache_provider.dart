import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local_posts_repository_hive.dart';

part 'media_local_cache_provider.g.dart';
@riverpod
class MediaLocalCache extends _$MediaLocalCache {
  final _localPostsRepositoryHive = LocalPostsRepositoryHive.instance;


  @override
  FutureOr<Uint8List?> build(String url) async {

    if(_localPostsRepositoryHive.mediaExists(url)){
      return _localPostsRepositoryHive.getMedia(url)!;
    }
    else{
      await _localPostsRepositoryHive.downloadMedia(url);
      final mediaData = _localPostsRepositoryHive.getMedia(url);

      return mediaData;
    }

  }
}
