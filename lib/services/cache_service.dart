import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';

class CacheService {
  static const String key = 'cached_posts';

  Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = posts.map((post) => json.encode(post.toJson())).toList();
    await prefs.setStringList(key, jsonList);
  }

  Future<List<Post>?> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(key);
    if (jsonList != null) {
      return jsonList.map((str) => Post.fromJson(json.decode(str))).toList();
    }
    return null;
  }
}
