import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class PostProvider with ChangeNotifier {
  final ApiService apiService;
  final CacheService cacheService;

  PostProvider({ApiService? apiService, CacheService? cacheService})
    : apiService = apiService ?? ApiService(),
      cacheService = cacheService ?? CacheService() {
    fetchPosts();
  }

  List<Post> _allPosts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = true;
  String? _errorMessage;
  final Set<int> _addedItemIds = {};
  List<Post> get posts => _filteredPosts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isAdded(int id) => _addedItemIds.contains(id);

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allPosts = await apiService.fetchPosts();
      try {
        await cacheService.savePosts(_allPosts);
      } catch (cacheError) {
        debugPrint(cacheError.toString());
      }
      _filteredPosts = _allPosts;
    } catch (e) {
      try {
        final cached = await cacheService.getCachedPosts();
        if (cached != null && cached.isNotEmpty) {
          _allPosts = cached;
          _filteredPosts = _allPosts;
          _errorMessage = 'No data available';
        } else {
          _errorMessage = e.toString();
        }
      } catch (cacheError) {
        _errorMessage = e.toString();
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredPosts = _allPosts;
    } else {
      _filteredPosts = _allPosts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void toggleItem(int id) {
    if (_addedItemIds.contains(id)) {
      _addedItemIds.remove(id);
    } else {
      _addedItemIds.add(id);
    }
    notifyListeners();
  }
}
