import 'package:atproto/atproto.dart' as atp; // ATProto API
import 'package:atproto_core/atproto_core.dart' as core; // ATProto core
import 'package:bluesky/bluesky.dart' as bsky; // Bluesky API

import 'dart:developer' as dev; // logging

import '../models/video_post_model.dart'; // video post model

class BlueskyService {
  // get video posts
  Future<List<VideoPost>> getVideoPosts() async {
    try {
      // create session using ATProto
      final session = await atp.createSession(
        identifier: 'selig46922@cyluna.com', // <-- your email
        password: 'bluesky.com', // <-- your password
      );

      // create Bluesky instance from session
      final bluesky = bsky.Bluesky.fromSession(session.data);

      // parse URI from videos feed
      final generatorUri = core.AtUri.parse(
        'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/thevids',
      );

      // list of video posts
      final videoPosts = <VideoPost>[];

      // cursor for pagination
      String? cursor;

      // check if we got our limit
      while (videoPosts.length < 100) {
        // call api
        final response = await bluesky.feed.getFeed(
          limit: 100,
          generatorUri: generatorUri,
          cursor: cursor,
        );

        // loop through the posts
        for (final post in response.data.feed) {
          // embed data
          final embed = post.post.embed;

          // check if the post has embed data
          if (embed?.data != null) {
            try {
              // retrieve data
              final userName = '${post.post.author.displayName}';
              final userHandle = '@${post.post.author.handle}';
              final userPhoto = '${post.post.author.avatar}';
              final video = (embed?.data as dynamic).playlist;
              final thumbnail = (embed?.data as dynamic).thumbnail;

              // fill up our model
              videoPosts.add(
                VideoPost(
                  userName: userName,
                  userHandle: userHandle,
                  userPhoto: userPhoto,
                  video: video,
                  thumbnail: thumbnail,
                ),
              );

              // if we get 100 video posts --> then break our loop
              if (videoPosts.length >= 100) break;
            } catch (e) {
              dev.log("Error: $e", name: "file: bluesky_service.dart");
              rethrow;
            }
            // check if there are no more posts to fetch --> then break our loop
            if (response.data.feed.isEmpty || response.data.cursor == null) {
              break;
            }
            // update the cursor for the next batch of posts
            cursor = response.data.cursor;
          }
        }
      }

      return videoPosts;
    } catch (e) {
      dev.log('Error fetching feed: $e', name: "file: bluesky_service.dart");
      rethrow;
    }
  }
}
