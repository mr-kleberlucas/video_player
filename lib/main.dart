import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart'; // BLoC
import 'package:video_player_shorts/blocs/video_feed_bloc.dart'; // video feed bloc
import 'package:video_player_shorts/screens/video_feed_screen.dart'; // video feed screen
import 'package:video_player_shorts/services/bluesky_service.dart'; // bluesky service


void main() {
  // initialize the bluesky service
  final blueskyService = BlueskyService();

  // run app with the bloc provider
  runApp(
    MultiBlocProvider(
      providers: [
        // provide VideoFeedBloc instance the bluesky service
        BlocProvider(create: (context) => VideoFeedBloc(blueskyService)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Shorts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),
      home: const VideoFeedScreen(),
    );
  }
}
