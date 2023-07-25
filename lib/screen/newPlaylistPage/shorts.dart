// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:video_player/video_player.dart';

// class ShortsPage extends StatefulWidget {
//   final List<AssetEntity> videos;

//   const ShortsPage({Key? key, required this.videos}) : super(key: key);

//   @override
//   _ShortsPageState createState() => _ShortsPageState();
// }

// class _ShortsPageState extends State<ShortsPage> {
//   late final List<VideoPlayerController> _controllers;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the video player controllers
//     _controllers = widget.videos.map((video) {
//       return VideoPlayerController.file(
//         File(video.relativePath.toString()),
//       )..initialize();
//     }).toList();
//   }

//   @override
//   void dispose() {
//     // Dispose of the video player controllers
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorWhite,
//       body: ListView.builder(
//         itemCount: widget.videos.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: AspectRatio(
//               aspectRatio: _controllers[index].value.aspectRatio,
//               child: VideoPlayer(_controllers[index]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
