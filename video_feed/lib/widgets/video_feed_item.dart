import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_feed/domain/models/post.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_feed/widgets/video_card_widget.dart';


class VideoFeedItem extends StatefulWidget {
  final Post post;

  VideoFeedItem({required this.post});

  @override
  _VideoFeedItemState createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem> {
  List<Post> replies = [];
  bool isLoadingReplies = false;
  late PageController _pageController;
  bool isMainVideo = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchReplies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchReplies() async {
    setState(() {
      isLoadingReplies = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.wemotions.app/posts/${widget.post.id}/replies'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success' && data['post'] is List) {
          List<Post> newReplies = (data['post'] as List)
              .map((postData) => Post.fromJson(postData))
              .toList();

          setState(() {
            replies = newReplies;
            isLoadingReplies = false;
          });
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load replies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching replies: $e');
      setState(() {
        isLoadingReplies = false;
      });
      showToast('Failed to load replies. Please try again.');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void showNotification(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.deepPurple.withOpacity(0.7),
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          isMainVideo = index == 0;
        });
        showNotification(isMainVideo ? "Main Video" : "Replies");
      },
      children: [
        VideoCard(post: widget.post),
        if (isLoadingReplies)
          Center(child: SpinKitRing(color: Colors.deepPurple, size: 50.0))
        else if (replies.isEmpty)
          Center(
            child: Text(
              'No replies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        else
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: replies.length,
            itemBuilder: (context, index) {
              return VideoCard(post: replies[index]);
            },
          ),
      ],
    );
  }
}