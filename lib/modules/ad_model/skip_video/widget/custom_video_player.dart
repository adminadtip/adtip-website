import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final double? height;
  const CustomVideoPlayer({Key? key, required this.videoUrl, this.height})
      : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      // Handle video URL change (e.g., reload the video)
      print('Video URL changed: ${widget.videoUrl}');
      initializeVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height ?? 160,
        child: Chewie(
          controller: chewieController!,
        ));
  }

  void initializeVideo() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        showOptions: false,
        allowPlaybackSpeedChanging: false,
        autoInitialize: true,
        aspectRatio: 16 / 9,
        errorBuilder: (context, error) {
          return const Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }
}
