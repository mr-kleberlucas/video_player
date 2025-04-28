import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart'; // BLoC

import '../blocs/video_feed_bloc.dart'; // video feed bloc

import '../widgets/video_player_widget.dart'; // video player widget

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  // controller
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // listener
    context.read<VideoFeedBloc>().add(LoadVideos());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BloC Builder
      body: BlocBuilder<VideoFeedBloc, VideoFeedState>(
        builder: (context, state) {
          // loading
          if (state is VideoFeedLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // error
          if (state is VideoFeedError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          // loaded
          if (state is VideoFeedLoaded) {
            // if no videos --> then show text
            if (state.videoUrls.isEmpty) {
              return const Center(child: Text('No videos found'));
            }

            // page view
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: state.videoUrls.length,
              itemBuilder: (context, index) {
                // video player widget
                return VideoPlayerWidget(
                  videoUrl: state.videoUrls[index],
                  userName: state.userNames[index],
                  userPhoto: state.userPhotos[index],
                  userHandle: state.userHandles[index],
                  thumbnailUrl: state.thumbnailUrls[index],
                );
              },
            );
          }

          // default
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
