// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:photo_manager/photo_manager.dart';
// import 'package:video_player/video_player.dart';

// class VideoTile extends StatefulWidget {
//   VideoTile(
//       {super.key, required this.video, this.snappageIndex, this.currentIndex});

//   final AssetEntity video;
//   final int snappageIndex;
//   final int currentIndex;
//   @override
//   State<VideoTile> createState() => _VideoTileState();
// }

// class _VideoTileState extends State<VideoTile> {
//   late VideoPlayerController _videoController;

//   late Future _initializeVideoPlayer;

//   @override
//   void initState() {
//     activateController();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();

//     super.dispose();
//   }

//   activateController() async {
//     _videoController =
//         VideoPlayerController.file(File((await widget.video.file)?.path ?? ''));
//     _initializeVideoPlayer = _videoController.initialize();
//     _videoController.play();
//     _videoController.setLooping(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     (widget.snappageIndex == widget.currentIndex)
//         ? _videoController.play()
//         : _videoController.pause();

//     return Container(
//       color: Colors.black,
//       child: FutureBuilder(
//         future: _initializeVideoPlayer,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return VideoPlayer(_videoController);
//           } else {
//             return Container(
//               color: Colors.black,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
