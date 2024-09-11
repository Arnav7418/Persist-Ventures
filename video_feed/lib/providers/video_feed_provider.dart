// lib/providers/video_feed_provider.dart
import 'package:flutter/foundation.dart';
import '../domain/models/post.dart';
import '../domain/services/api_service.dart';

class VideoFeedProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  int _currentPage = 1;
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final newPosts = await _apiService.fetchPosts(_currentPage, 10);
      _posts.addAll(newPosts);
      _currentPage++;
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}