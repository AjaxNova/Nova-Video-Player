


import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../functions/history.dart';

class ShortsPageTry extends StatefulWidget {

  const ShortsPageTry({super.key, required this.shortVideos});

  final List<AssetEntity> shortVideos ;

  @override
  // ignore: library_private_types_in_public_api
  _ShortsPageTryState createState() => _ShortsPageTryState();
}

class _ShortsPageTryState extends State<ShortsPageTry> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.shortVideos.length,
        itemBuilder: (BuildContext context, int index) {
             
           return VideoPLayerPageForShorts(video: widget.shortVideos[index]);
            
        },
        onPageChanged: (int pageIndex) {
          setState(() {
            
             _currentPageIndex = pageIndex;
          });
        },
      ),
    );
  }
}



class VideoPLayerPageForShorts extends StatefulWidget {
  final AssetEntity video;

  const VideoPLayerPageForShorts({super.key, required this.video});

  @override
  State<VideoPLayerPageForShorts> createState() =>
      _VideoPLayerPageForShortsState();
}

class _VideoPLayerPageForShortsState extends State<VideoPLayerPageForShorts>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool loaded = false;
  bool isPortrait = true;

  @override
  void initState() {
    super.initState();
    HistoryVideos.addToHistory(widget.video);
    _initializeVideoPlayer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(
        File((await widget.video.file)?.path ?? ''));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    setState(() {
      _chewieController = ChewieController(
         errorBuilder: (context, errorMessage) {
            return const Text('Video Error');
         },
          showControlsOnInitialize: false,
          showControls: true,
          allowMuting: false,
          allowFullScreen: false,
          autoInitialize: true,
          
          // overlay: BottomAppBar(child: Text(widget.video.title!,style: TextStyle(color: colorWhite),)),
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: true,
          allowedScreenSleep: true,
          zoomAndPan: true,
          fullScreenByDefault: false);
          loaded = true;
          final size = MediaQuery.of(context).size;
          isPortrait = size.height > size.width;
          if (isPortrait) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
          _chewieController.enterFullScreen();
          }

    });
  }


  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            backgroundColor: Colors.black,
            body: OrientationBuilder(
              builder: (context, orientation) {
              
                return Chewie(
                  controller: _chewieController,
                );
              },
            ),
          )
        : const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
  }
}


// class VideoPLayerPageForShorts extends StatefulWidget {
//   final AssetEntity video;

//   const VideoPLayerPageForShorts(
//       {super.key, required this.video});

//   @override
//   State<VideoPLayerPageForShorts> createState() => _VideoPLayerPageForShortsState();
// }

// class _VideoPLayerPageForShortsState extends State<VideoPLayerPageForShorts> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;
//   int _currentIndex = 0;
//   bool loaded = false;

//   @override
//   void initState() {
//     super.initState();
//     HistoryVideos.addToHistory(widget.video);
//     _initializeVideoPlayer();
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   void _initializeVideoPlayer() async {
//     _videoPlayerController = VideoPlayerController.file(
//         File((await widget.video.file)?.path ?? ''));
//     await _videoPlayerController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//     setState(() {
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         autoPlay: true,
//         looping: true,
//         allowFullScreen: false,
//         materialProgressColors: ChewieProgressColors(
//           playedColor: Colors.white
//         ),
//         zoomAndPan: true
//       );
//       loaded = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loaded
//         ? Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.black,
//             ),
//             backgroundColor: Colors.black,
//             body: _chewieController.videoPlayerController.value.isInitialized
//                 ? GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _chewieController.pause();
//                       });
//                     },
//                     child: Center(
//                       child: SizedBox(
//                         // height: MediaQuery.of(context).size.height / 2,
//                         height: double.infinity,
//                         child: Chewie(

//                          controller: _chewieController,
                         
//                         ),
//                       ),
//                     ),
//                   )
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//           )
//         : const Scaffold(
//             backgroundColor: Colors.black,
//             body: Center(
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             ),
//           );b
//          }
// }






// class VideoPlayerWidget extends StatefulWidget {
//   final AssetEntity video;

//   const VideoPlayerWidget({required this.video});

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
// late VideoPlayerController _controller;
// bool status = false;
// late  bool _isPortrait;


// Future<void> _initController() async {
//   final file = await widget.video.file;
//   _controller = VideoPlayerController.file(file!);
//   await _controller.initialize();


//   setState(() {
//     status=true;
//       _isPortrait = _controller.value.size.aspectRatio < 1;
//       print(_isPortrait);
//       _controller.play();
//   });
// }

// @override
// void initState() {
//      _initController();
//     super.initState();
//   }




// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }

// @override
// Widget build(BuildContext context) {
//   return status
//       ?     Container(
//       width: double.infinity,
//       height: _isPortrait ? null : MediaQuery.of(context).size.height,
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     )
//       : Scaffold(backgroundColor: colorBlack, body: Center(child: CircularProgressIndicator()));
// }

// }












  // @override
  // void didChangeMetrics() {
  //   setState(() {
  //     final size = MediaQuery.of(context).size;
  //     isPortrait = size.height > size.width;
  //     if (isPortrait) {
  //       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  //       _chewieController.enterFullScreen();
  //     } else {
  //       // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  //       // _chewieController?.exitFullScreen();
  //     }
  //   });
  // }




  // class VideoPlayerWidget extends StatefulWidget {
//   final AssetEntity video;

//   VideoPlayerWidget({required this.video});

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//    bool _isPortrait = true;
//    bool status = false;

// Future<void> _initController() async {
//   final file = await widget.video.file;
//   _controller = VideoPlayerController.file(file!);
//   await _controller.initialize();


//   setState(() {
//     status=true;
//      _isPortrait = _controller.value.size.aspectRatio < 1;
//       _controller.play();
//   });
// }
  


//   @override
//   void initState() {
//     super.initState();
    
 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: _isPortrait ? null : MediaQuery.of(context).size.height,
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }





// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:nova_videoplayer/screen/newPlaylistPage/shorts_page/content_screen.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:tiktoklikescroller/tiktoklikescroller.dart';

// class ShortsPageTry extends StatelessWidget {
//   List<AssetEntity> videos = theAllShortVideos;
//   final Controller controller = Controller()
//     ..addListener((event) {
//       _handleCallbackEvent(event.direction, event.success);
//     });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: colorBlack,
//           child: Stack(
//             children: [
//               //We need swiper for every content
//               Swiper(
//                 itemBuilder: (BuildContext context, int index) {
//                   return ContentScreen(
//                     video: videos[index],
//                   );
//                 },
//                 itemCount: videos.length,
//                 scrollDirection: Axis.vertical,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       'Flutter Shorts',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Icon(Icons.camera_alt),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
//     {int? currentIndex}) {
//   print(
//       "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
// }


 

// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/screen/newPlaylistPage/shorts_page/video_tile.dart';
// import 'package:photo_manager/photo_manager.dart';

// class ShortsPageTry extends StatefulWidget {
//   const  ShortsPageTry({required this.shortVideos, super.key});
//   final List<AssetEntity>shortVideos;
//   @override
//   State<ShortsPageTry> createState() => _ShortsPageTryState();
// }

// class _ShortsPageTryState extends State<ShortsPageTry> {
  
//   int _snappedIndex=0;

//  @override
//  void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       onPageChanged: (int page) {  
//         setState(() {
//           _snappedIndex=page;
//         });     
//       },
//       scrollDirection: Axis.vertical,
//       itemCount: widget.shortVideos.length,
//       itemBuilder: (context, index) {
//         return Stack(
//         alignment:Alignment.bottomCenter ,
//         children: [
//          Container(
//           color: Colors.red,
//           child:  VideoTile(video: widget.shortVideos[index],
//           currentIndex: index,
//           snappageIndex:_snappedIndex ,
//           ),
//           ),
         
          
//         ],
//         );
//       },
//     );
//   }
// }




//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
// import 'dart:io';

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:video_player/video_player.dart';

// import '../../../functions/history.dart';

// class ShortsPageTry extends StatefulWidget {
//   const ShortsPageTry({required this.shortVideos});

//   final List<AssetEntity> shortVideos;

//   @override
//   _ShortsPageTryState createState() => _ShortsPageTryState();
// }

// class _ShortsPageTryState extends State<ShortsPageTry> {
//   late PageController _pageController;
//   int _currentPageIndex = 0;
//   int _lastPlayedIndex = 0;
//   bool _pageFullySwiped = true;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentPageIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _playLastVideo() {
//     if (_lastPlayedIndex != _currentPageIndex) {
//       setState(() {
//         _currentPageIndex = _lastPlayedIndex;
//         _pageFullySwiped = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onVerticalDragStart: (_) => _pageFullySwiped = false,
//         onVerticalDragUpdate: (details) {
//           if (!_pageFullySwiped && details.primaryDelta! < -20) {
//             setState(() {
//               _lastPlayedIndex = _currentPageIndex;
//               _pageFullySwiped = true;
//             });
//           }
//         },
//         child: PageView.builder(
//           scrollDirection: Axis.vertical,
//           controller: _pageController,
//           itemCount: widget.shortVideos.length,
//           itemBuilder: (BuildContext context, int index) {
//             return VideoPLayerPageForShorts(
//               video: widget.shortVideos[index],
//               playOnLoad: true,
              
//             );
//           },
//           onPageChanged: (int pageIndex) {
//             setState(() {
//               _currentPageIndex = pageIndex;
//               _playLastVideo();
//             });
//           },
//         ),
//       ),
//     );
//   }
// }


// class VideoPLayerPageForShorts extends StatefulWidget {
//   final AssetEntity video;
//   final bool playOnLoad;

//   const VideoPLayerPageForShorts({
//     Key? key,
//     required this.video,
//      this.playOnLoad=true
//   }) : super(key: key);

//   @override
//   State<VideoPLayerPageForShorts> createState() =>
//       _VideoPLayerPageForShortsState();
// }

// class _VideoPLayerPageForShortsState extends State<VideoPLayerPageForShorts>
//     with WidgetsBindingObserver {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;
//   bool loaded = false;
//   bool isPortrait = true;

//   @override
//   void initState() {
//     super.initState();
//     HistoryVideos.addToHistory(widget.video);
//     _initializeVideoPlayer();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   void _initializeVideoPlayer() async {
//     _videoPlayerController = VideoPlayerController.file(
//         File((await widget.video.file)?.path ?? ''));
//     await _videoPlayerController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: widget.playOnLoad,
//       looping: true,
//     );
//     setState(() {
//       _chewieController = ChewieController(
//           errorBuilder: (context, errorMessage) {
//             return const Text('Video Error');
//           },
//           showControlsOnInitialize: false,
//           showControls: true,
//           allowMuting: false,
//           allowFullScreen: false,
//           autoInitialize: true,
//           videoPlayerController: _videoPlayerController,
//           autoPlay: widget.playOnLoad,
//           looping: true,
//           allowedScreenSleep: true,
//           zoomAndPan: true,
//           fullScreenByDefault: false);
//       loaded = true;
//       final size = MediaQuery.of(context).size;
//       isPortrait = size.height > size.width;
//       if (isPortrait) {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//         _chewieController.enterFullScreen();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loaded
//         ? Scaffold(
//             backgroundColor: Colors.black,
//             body: OrientationBuilder(
//               builder: (context, orientation) {
//                 if (!isPortrait) {
//                   _chewieController.exitFullScreen();
//                   SystemChrome.setEnabledSystemUIMode(
//                       SystemUiMode.manual, overlays: []);
//                 }
//                 return Chewie(
//                   controller: _chewieController,
//                 );
//               },
//             ),
//           )
//         : const Scaffold(
//             backgroundColor: Colors.black,
//             body: Center(
//               child: CircularProgressIndicator(
//                 color: Colors.black,
//               ),
//             ),
//           );
//   }
// }