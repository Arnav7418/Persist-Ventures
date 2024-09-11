
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/video_feed_provider.dart';
import 'providers/video_replies_provider.dart';
import 'presentation/screens/video_feed_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoFeedProvider()),
        ChangeNotifierProvider(create: (_) => VideoRepliesProvider()),
      ],
      child: MaterialApp(
        title: 'Video Feed App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: VideoFeedScreen(),
      ),
    );
  }
}