// // import 'dart:io';

// // import 'package:chewie/chewie.dart';
// // import 'package:flutter/material.dart';
// // import 'package:photo_manager/photo_manager.dart';
// // import 'package:video_player/video_player.dart';

// // import 'like_icon.dart';
// // import 'options.dart';

// // class ContentScreen extends StatefulWidget {
// //   final AssetEntity video;

// //   const ContentScreen({Key? key,required this.video}) : super(key: key);

// //   @override
// //   _ContentScreenState createState() => _ContentScreenState();
// // }

// // class _ContentScreenState extends State<ContentScreen> {
// //   late VideoPlayerController _videoPlayerController;
// //   ChewieController? _chewieController;
// //   bool _liked = false;
// //   @override
// //   void initState() {
// //     initializePlayer();
// //     super.initState();

// //   }

// //   Future initializePlayer() async {
// //     //  _videoPlayerController = VideoPlayerController.file(await widget.video.file!);
// //      VideoPlayerController.file(File((await widget.video.file)?.path ?? ''));

// //     await Future.wait([_videoPlayerController.initialize()]);
// //     _chewieController = ChewieController(
// //       videoPlayerController: _videoPlayerController,
// //       autoPlay: true,
// //       showControls: false,
// //       looping: true,
// //     );
// //     setState(() {});
// //   }

// //   @override
// //   void dispose() {
// //     _videoPlayerController.dispose();
// //     _chewieController!.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       fit: StackFit.expand,
// //       children: [
// //         _chewieController != null &&
// //                 _chewieController!.videoPlayerController.value.isInitialized
// //             ? GestureDetector(
// //                 onDoubleTap: () {
// //                   setState(() {
// //                     _liked = !_liked;
// //                   });
// //                 },
// //                 child: Chewie(
// //                   controller: _chewieController!,
// //                 ),
// //               )
// //             : Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: const [
// //                   CircularProgressIndicator(),
// //                   SizedBox(height: 10),
// //                   Text('Loading...')
// //                 ],
// //               ),
// //         if (_liked)
// //           Center(
// //             child: LikeIcon(),
// //           ),
// //         OptionsScreen()
// //       ],
// //     );
// //   }
// // }

// import 'dart:io';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:video_player/video_player.dart';

// import 'like_icon.dart';
// import 'options.dart';

// class ContentScreen extends StatefulWidget {
//   final AssetEntity video;

//   const ContentScreen({Key? key, required this.video}) : super(key: key);

//   @override
//   _ContentScreenState createState() => _ContentScreenState();
// }

// class _ContentScreenState extends State<ContentScreen> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _liked = false;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   Future initializePlayer() async {
//     _videoPlayerController =
//         VideoPlayerController.file(File((await widget.video.file)?.path ?? ''));
//     await _videoPlayerController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       showControls: false,
//       looping: true,
//     );
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         _chewieController != null &&
//                 _chewieController!.videoPlayerController.value.isInitialized
//             ? GestureDetector(
//                 onDoubleTap: () {
//                   setState(() {
//                     _liked = !_liked;
//                   });
//                 },
//                 child: Chewie(
//                   controller: _chewieController!,
//                 ),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 10),
//                   Text('Loading...')
//                 ],
//               ),
//         if (_liked)
//           Center(
//             child: LikeIcon(),
//           ),
//         OptionsScreen(video: widget.video)
//       ],
//     );
//   }
// }
