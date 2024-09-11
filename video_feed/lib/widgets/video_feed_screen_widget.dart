// lib/widgets/video_feed_item.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/models/post.dart';
import '../providers/video_replies_provider.dart';
import 'package:video_feed/widgets/video_card_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VideoFeedItem extends StatefulWidget {
  final Post post;

  VideoFeedItem({required this.post});

  @override
  _VideoFeedItemState createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem> {
  late PageController _pageController;
  bool isMainVideo = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoRepliesProvider>(context, listen: false).fetchReplies(widget.post.id);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
        Consumer<VideoRepliesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: SpinKitRing(color: Colors.deepPurple, size: 50.0));
            } else if (provider.replies.isEmpty) {
              return Center(
                child: Text(
                  'No replies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: provider.replies.length,
                itemBuilder: (context, index) {
                  return VideoCard(post: provider.replies[index]);
                },
              );
            }
          },
        ),
      ],
    );
  }
}