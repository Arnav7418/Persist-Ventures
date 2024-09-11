// lib/providers/video_replies_provider.dart
import 'package:flutter/foundation.dart';
import '../domain/models/post.dart';
import '../domain/services/api_service.dart';

class VideoRepliesProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _replies = [];
  bool _isLoading = false;

  List<Post> get replies => _replies;
  bool get isLoading => _isLoading;

  Future<void> fetchReplies(int postId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _replies = await _apiService.fetchReplies(postId);
    } catch (e) {
      print('Error fetching replies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
