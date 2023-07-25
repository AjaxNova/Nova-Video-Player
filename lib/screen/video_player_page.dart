import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
//import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../provider/historyprovider/history_provider.dart';

class VideoPLayerPage extends StatefulWidget {
  final List<AssetEntity> videoList;
  final int initialIndex;

  const VideoPLayerPage(
      {super.key, required this.videoList, required this.initialIndex});

  @override
  State<VideoPLayerPage> createState() => _VideoPLayerPageState();
}

class _VideoPLayerPageState extends State<VideoPLayerPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  int _currentIndex = 0;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    Provider.of<HistoryProvider>(context, listen: false)
        .addTohistory(widget.videoList[widget.initialIndex]);
    // Provider.of<HistoryProvider>(context, listen: false).addToHistory(
    //     id: widget.videoList[widget.initialIndex].id,
    //     video: widget.videoList[widget.initialIndex]);
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _chewieController.pause();
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(
        File((await widget.videoList[_currentIndex].file)?.path ?? ''));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
      );
      loaded = true;
    });
  }

  Future<void> _nextVideo() async {
    final int nextIndex = _currentIndex + 1;
    if (nextIndex < widget.videoList.length) {
      _currentIndex = nextIndex;
      await _chewieController.pause();
      await _videoPlayerController.pause();
      await _videoPlayerController.dispose();
      // HistoryVideos.addToHistory(widget.videoList[nextIndex]);

      _initializeVideoPlayer();
    }
  }

  Future<void> _previousVideo() async {
    final int previousIndex = _currentIndex - 1;
    if (previousIndex >= 0) {
      _currentIndex = previousIndex;
      await _chewieController.pause();
      await _videoPlayerController.pause();
      await _videoPlayerController.dispose();
      // HistoryVideos.addToHistory(widget.videoList[previousIndex]);
      _initializeVideoPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.black,
            // ),
            backgroundColor: Colors.black,
            body: _chewieController.videoPlayerController.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _chewieController.pause();
                      });
                    },
                    child: Center(
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height / 2,
                        height: double.infinity,
                        child: Chewie(
                          controller: _chewieController,
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousVideo,
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_chewieController.isPlaying) {
                          _chewieController.pause();
                        } else {
                          _chewieController.play();
                        }
                      });
                    },
                    icon: Icon(
                      _chewieController.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: _nextVideo,
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        : const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}

////////////////////////////////////////////////////stable///////////////////////

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//   final List<AssetEntity> videos;
//   final int initialIndex;
//   final double aspectRatio;
//   final ChewieController chewieeController;

//   const VideoPlayerWidget({
//     Key? key,
//     // required this.videoPlayerController,
//     required this.videos,
//     required this.initialIndex,
//     required this.aspectRatio,
//     required this.chewieeController,
//     required this.videoPlayerController,
//   }) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late ChewieController _chewieController;

//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _chewieController = widget.chewieeController;
//   }

//   @override
//   void dispose() {
//     widget.videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   void _playPauseVideo() {
//     setState(() {
//       _isPlaying = !_isPlaying;
//       if (_isPlaying) {
//         widget.videoPlayerController.play();
//       } else {
//         widget.videoPlayerController.pause();
//       }
//     });
//   }

//   void _skipForward() {
//     final Duration currentPosition =
//         widget.videoPlayerController.value.position;
//     final Duration newDuration = currentPosition + const Duration(seconds: 5);
//     widget.videoPlayerController.seekTo(newDuration);
//   }

//   void _skipBackward() {
//     final Duration currentPosition =
//         widget.videoPlayerController.value.position;
//     final Duration newDuration = currentPosition - const Duration(seconds: 5);
//     widget.videoPlayerController.seekTo(newDuration);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: colorBlack,
//         body: Stack(
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: SizedBox(
//                 width: widget.videos[widget.initialIndex].longitude,
//                 height: double.infinity,
//                 child: AspectRatio(
//                   aspectRatio: widget.aspectRatio,
//                   child: Chewie(
//                     controller: _chewieController,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
