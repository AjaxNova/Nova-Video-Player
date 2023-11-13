// import 'package:flutter/material.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// // import 'package:nova_videoplayer/functions/history.dart';
// import 'package:nova_videoplayer/screen/home_with_bottom.dart';
// import 'package:photo_manager/photo_manager.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   List<AssetPathEntity> allFolderswithVideos = [];
//   List<AssetEntity> allVideosList = [];
//   bool isLoading = false;
//   @override
//   void initState() {
//     super.initState();

//     fetchvideos();
//     getAllPlayListFromDb();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: Stack(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * .30,
//                 width: MediaQuery.of(context).size.width * .7,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/SplashLogo.png'),
//                         fit: BoxFit.fitWidth)),
//               ),
//               Positioned(
//                   bottom: MediaQuery.of(context).size.height * .08,
//                   right: MediaQuery.of(context).size.width * .05,
//                   child: Text(
//                     'VideoPlayer',
//                     style: TextStyle(
//                         fontFamily: "Inter",
//                         fontSize: MediaQuery.of(context).size.height * 0.023,
//                         color: Colors.white),
//                   ))
//             ],
//           ),
//         )
//         //Stack(children: [
//         //   Positioned(
//         //       top: 238,
//         //       left: 50,
//         //       child: Container(
//         //           width: 287,
//         //           height: 251,
//         //           decoration: const BoxDecoration(
//         //             image: DecorationImage(
//         //                 image: AssetImage('assets/images/SplashLogo.png'),
//         //                 fit: BoxFit.fitWidth),
//         //           ))),
//         //   const Positioned(
//         //       top: 400,
//         //       left: 195,
//         //       child: Text(
//         //         'Video PLayer',
//         //         textAlign: TextAlign.left,
//         //         style: TextStyle(
//         //             color: Color.fromRGBO(255, 255, 255, 1),
//         //             fontFamily: 'Inter',
//         //             fontSize: 16,
//         //             letterSpacing: 0,
//         //             fontWeight: FontWeight.normal,
//         //             height: 1),
//         //       )),
//         // ]),
//         );
//   }

//   ///////////////functions//////////////////////////
//   //function fetching the videos
//   fetchvideos() async {
//     setState(() => isLoading = true);

//     final albums = await PhotoManager.getAssetPathList(type: RequestType.video);
//     // final albums= await PhotoManager.getAssetPathList(type: RequestType.all);
//     final recentAlbum = albums.first;
//     final assetCount = await recentAlbum.assetCountAsync;
//     final recentAssets =
//         await recentAlbum.getAssetListRange(start: 0, end: assetCount - 1);

//     // dummyAssets.sort((a, b) => a.title!.compareTo(b.title!));
//     // final List<AssetEntity> videoList = dummyAssets;

//     setState(() {
//       allFolderswithVideos = albums;
//       allVideosList = recentAssets.toList();
//       isLoading = false;
//     });
//     final dummyAssets = recentAssets;
//     fetchVideosForAddVideoPage(dummyAssets: dummyAssets);
//     gotoHome();
//   }

//   ////////////////////////////////////////////////////
//   /////function to navigate home
//   void gotoHome() {
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => HomeScreen(
//           assets: allVideosList, foldersWithVideos: allFolderswithVideos),
//     ));
//   }

//   fetchVideosForAddVideoPage({required List<AssetEntity>? dummyAssets}) async {
//     List<AssetEntity> myVideosData;
//     dummyAssets!.sort((a, b) => a.title!.compareTo(b.title!));
//     myVideosData = dummyAssets;

//     setState(() {
//       theAllVideosListFortheSelectionPage = myVideosData;
//     });
//     theAllShortVideos =
//         await getLandscapeVideos(theAllVideosListFortheSelectionPage);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/provider/playlistDbProvider/playlist_db_provider.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/screen/home_with_bottom.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void updateState() {
    setState(() {
      // Your state changes go here
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final playPro = Provider.of<PlaylistProvider>(context, listen: false);
      playPro.fetchAllPlayList();

      final provi = Provider.of<VideoDataModel>(context, listen: false);
      final data = await provi.checkForPermission();
      if (data != "permission_granted") {
        await _onAlertButtonPressed(context, updateState);
      } else {
        provi.fetchVideoList(context).then(
              (value) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            );
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              // duration: const Duration(seconds: 2),
              height: MediaQuery.of(context).size.height * .30,
              width: MediaQuery.of(context).size.width * .7,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage('assets/images/SplashLogo.png'),
              //       fit: BoxFit.fitWidth),
              // ),
              child: SvgPicture.asset('assets/images/SplashLogoSvg.svg'),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .08,
              right: MediaQuery.of(context).size.width * .05,
              child: Text(
                'VideoPlayer',
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: MediaQuery.of(context).size.height * 0.023,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_onAlertButtonPressed(BuildContext context, VoidCallback refresh) async {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Storage Permission Denied",
    desc: "Go to settings and grant storage permission.",
    style: AlertStyle(
      isCloseButton: false,
      backgroundColor: Colors.black,
      animationType: AnimationType.fromTop,
      titleStyle: const TextStyle(
        color: Colors.red,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      descStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
      isOverlayTapDismiss: false,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    ),
    buttons: [
      DialogButton(
        color: colorGreen,
        onPressed: () async {
          await openAppSettings();
        },
        width: 100,
        splashColor: colorBlack,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, color: Colors.black, size: 14),
            SizedBox(width: 8),
            Text(
              "Settings",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      DialogButton(
        color: colorGreen,
        onPressed: () async {
          refresh();
        },
        width: 100,
        splashColor: colorBlack,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, color: Colors.black, size: 14),
            SizedBox(width: 8),
            Text(
              "refresh",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      )
    ],
  ).show();
}
