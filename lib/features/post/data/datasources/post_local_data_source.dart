import 'dart:convert';
import 'package:clean_architecture/core/databases/cache/cache_helper.dart';
import 'package:clean_architecture/core/errors/expentions.dart';
import 'package:clean_architecture/features/post/data/models/post_model.dart';


class PostLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedPost";
  PostLocalDataSource({required this.cache});

  cachePost(PostModel? postToCache) {
    if (postToCache != null) {
      cache.saveData(key: key, value: json.encode(postToCache.toJson()));
    } else {
      throw CacheException(errorMessage: "No Internet Connection");
    }
  }

  Future<PostModel> getLastPost() {
    final jsonString = cache.getDataString(key: key);

    if (jsonString != null) {
      return Future.value(PostModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException(errorMessage: "No Internet Connection");
    }
  }
}
