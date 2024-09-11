import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://api.wemotions.app';

  Future<List<Post>> fetchPosts(int page, int pageSize) async {
    final response = await http.get(Uri.parse('$baseUrl/feed?page=$page&page_size=$pageSize'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['posts'] as List).map((postData) => Post.fromJson(postData)).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }

  Future<List<Post>> fetchReplies(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId/replies'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success' && data['post'] is List) {
        return (data['post'] as List).map((postData) => Post.fromJson(postData)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load replies: ${response.statusCode}');
    }
  }
}
