import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local_posts_repository_hive.dart';
import 'package:http/http.dart' as http;

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
      if(kIsWeb){
        //blob url
          final uri = Uri.parse(url);
          final client = http.Client();
          final request = await client.get(uri);
          _localPostsRepositoryHive.putMedia(url, request.bodyBytes);
      }else{
      await _localPostsRepositoryHive.downloadMedia(url);
      }
      final mediaData = _localPostsRepositoryHive.getMedia(url);
      return mediaData;
    }

  }
}
