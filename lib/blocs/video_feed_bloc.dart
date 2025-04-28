import 'package:flutter_bloc/flutter_bloc.dart'; // BLoC
import 'package:equatable/equatable.dart'; // Equatable

import '../services/bluesky_service.dart'; // Bluesky service

import 'dart:developer' as dev; // logging

// define events for the BLoC
abstract class VideoFeedEvent extends Equatable {
  const VideoFeedEvent();

  @override
  List<Object> get props => [];
}

// load videos event
class LoadVideos extends VideoFeedEvent {}

// define states for the BLoC
abstract class VideoFeedState extends Equatable {
  const VideoFeedState();

  @override
  List<Object> get props => [];
}

// initial state of the BLoC
class VideoFeedInitial extends VideoFeedState {}

// loading state of the BLoC
class VideoFeedLoading extends VideoFeedState {}

// loaded state of the BLoC
class VideoFeedLoaded extends VideoFeedState {
  final List<String> videoUrls;
  final List<String> userNames;
  final List<String> userPhotos;
  final List<String> userHandles;
  final List<String> thumbnailUrls;

  const VideoFeedLoaded(
    this.videoUrls,
    this.userNames,
    this.userPhotos,
    this.userHandles,
    this.thumbnailUrls,
  );

  @override
  List<Object> get props => [
    videoUrls,
    userNames,
    userPhotos,
    userHandles,
    thumbnailUrls,
  ];
}

// error state
class VideoFeedError extends VideoFeedState {
  final String message;

  const VideoFeedError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class VideoFeedBloc extends Bloc<VideoFeedEvent, VideoFeedState> {
  // bluesky service
  final BlueskyService _blueskyService;

  VideoFeedBloc(this._blueskyService) : super(VideoFeedInitial()) {
    on<LoadVideos>(_onLoadVideos);
  }

  // load videos
  Future<void> _onLoadVideos(
    LoadVideos event,
    Emitter<VideoFeedState> emit,
  ) async {
    try {
      // loading state
      emit(VideoFeedLoading());

      // get data from service
      final videoPosts = await _blueskyService.getVideoPosts();

      final videoUrls = videoPosts.map((post) => post.video).toList();
      final userNames = videoPosts.map((post) => post.userName).toList();
      final userPhotos = videoPosts.map((post) => post.userPhoto).toList();
      final userHandles = videoPosts.map((post) => post.userHandle).toList();
      final thumbnailUrls = videoPosts.map((post) => post.thumbnail).toList();

      // emit state
      emit(
        VideoFeedLoaded(
          videoUrls,
          userNames,
          userPhotos,
          userHandles,
          thumbnailUrls,
        ),
      );
    } catch (e) {
      dev.log("error: $e", name: "file: video_feed_bloc.dart");
      // error state
      emit(VideoFeedError(e.toString()));
      rethrow;
    }
  }
}
