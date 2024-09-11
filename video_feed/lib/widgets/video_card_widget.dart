// lib/widgets/video_card.dart
import 'package:flutter/material.dart';
import '../domain/models/post.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VideoCard extends StatefulWidget {
  final Post post;

  VideoCard({required this.post});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.post.videoLink));
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing video: $e');
      showToast('Failed to load video. Please try again.');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_isInitialized) {
      print("Video not initialized yet");
      showToast('Video is still loading. Please wait.');
      return;
    }

    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Image.network(widget.post.thumbnailUrl, fit: BoxFit.cover),
            Positioned.fill(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            if (!_isPlaying)
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                  ),
                  child: Icon(Icons.play_arrow, size: 64, color: Colors.white),
                ),
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.pictureUrl),
                ),
                title: Text(
                  widget.post.username,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 20),
                            SizedBox(width: 4),
                            Text(
                              '${widget.post.upvoteCount}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.remove_red_eye, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text(
                              '${widget.post.viewCount}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}