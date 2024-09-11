// lib/presentation/screens/video_feed_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/video_feed_provider.dart';
import 'package:video_feed/widgets/video_feed_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VideoFeedScreen extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoFeedProvider>(context, listen: false).fetchPosts();
    });
  }

  void _onScroll() {
    if (_pageController.position.pixels == _pageController.position.maxScrollExtent) {
      Provider.of<VideoFeedProvider>(context, listen: false).fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoFeedProvider>(
        builder: (context, provider, child) {
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: provider.posts.length + 1,
            itemBuilder: (context, index) {
              if (index < provider.posts.length) {
                return VideoFeedItem(post: provider.posts[index]);
              } else if (provider.isLoading) {
                return Center(
                  child: SpinKitWave(
                    color: Colors.deepPurple,
                    size: 50.0,
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}