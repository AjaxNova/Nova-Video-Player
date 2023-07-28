// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/services.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerPageWithChewie extends StatefulWidget {
//   final AssetEntity video;

//   VideoPlayerPageWithChewie({required this.video});

//   @override
//   _VideoPlayerPageWithChewieState createState() => _VideoPlayerPageWithChewieState();
// }

// class _VideoPlayerPageWithChewieState extends State<VideoPlayerPageWithChewie> {
//   late VideoPlayerController _videoPlayerController ;
//   late ChewieController _chewieController;
//   double _brightness = 1.0;
//   double _volume = 1.0;
//   bool isLoaded=false;
//   @override
//   void initState() {
//     super.initState();
//     initialiseTheController();
//   }
  

//     initialiseTheController()async{
//         _videoPlayerController=VideoPlayerController.file(File((await widget.video.file)?.path ?? '')); 
//     await _videoPlayerController.initialize();
//     setState(() {
//       isLoaded=true;
//     });
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: true,
//       allowFullScreen: true,
//       showControls: true,
//       // deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//       customControls: Container(
//     child: Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         GestureDetector(
//           onVerticalDragUpdate: (details) {
//   setState(() {
//     if (details.delta.dy > 0) {
//       _brightness = (_brightness - 0.1).clamp(0.0, 1.0);
//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        
//         systemNavigationBarColor: Colors.black,
//         statusBarColor: Colors.black,
//         statusBarBrightness: _brightness == 0 ? Brightness.dark : Brightness.light,
//         statusBarIconBrightness: _brightness == 0 ? Brightness.dark : Brightness.light,
//       ));
//     } else {
//       _brightness = (_brightness + 0.1).clamp(0.0, 1.0);
//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         systemNavigationBarColor: Colors.black,
//         statusBarColor: Colors.black,
//         statusBarBrightness: _brightness == 0 ? Brightness.dark : Brightness.light,
//         statusBarIconBrightness: _brightness == 0 ? Brightness.dark : Brightness.light,
//       ));
//     }
//   });
// },

//           onHorizontalDragUpdate: (details) {
//             setState(() {
//               if (details.delta.dx > 0) {
//                 _videoPlayerController.seekTo(Duration(milliseconds: _videoPlayerController.value.position.inMilliseconds + 500));
//               } else {
//                 _videoPlayerController.seekTo(Duration(milliseconds: _videoPlayerController.value.position.inMilliseconds - 500));
//               }
//             });
//           },
//           child: Container(
//             color: Colors.transparent,
//           ),
//         ),
//         Positioned(
//           left: 0,
//           bottom: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     if (_videoPlayerController.value.isPlaying) {
//                       _videoPlayerController.pause();
//                     } else {
//                       _videoPlayerController.play();
//                     }
//                   });
//                 },
//                 icon: Icon(
//                   _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 '${_durationToString(_videoPlayerController.value.position)} / ${_durationToString(_videoPlayerController.value.duration)}',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           right: 0,
//           bottom: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _volume = (_volume - 0.1).clamp(0.0, 1.0);
//                     _videoPlayerController.setVolume(_volume);
//                   });
//                 },
//                 icon: Icon(
//                   Icons.volume_down,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 '${(_volume * 100).toStringAsFixed(0)}%',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _volume = (_volume + 0.1).clamp(0.0, 1.0);
//                     _videoPlayerController.setVolume(_volume);
//                   });
//                 },
//                 icon: Icon(
//                   Icons.volume_up,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
//     );
//     }



//   @override
//   void dispose() {
//     super.dispose();
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//   }

//   String _durationToString(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorBlack,
//       body:isLoaded? Container(
//         child: Chewie(

//           controller: _chewieController,
          
//         ),
//       ):const CircularProgressIndicator()
//     );
//   }
// }

