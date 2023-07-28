import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/provider/video_data_provider.dart';
// import 'package:nova_videoplayer/functions/history.dart';
import 'package:nova_videoplayer/screen/home_with_bottom.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<AssetPathEntity> allFolderswithVideos = [];
  List<AssetEntity> allVideosList = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<VideoDataProvider>(context, listen: false).fetchvideos(context);
    //fetchvideos();
    getAllPlayListFromDb();
  }

  @override
  Widget build(BuildContext context) {
    VideoDataProvider provi = VideoDataProvider();
    provi.fetchvideos(context);
    /////call it here / // //////

    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .30,
                width: MediaQuery.of(context).size.width * .7,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/SplashLogo.png'),
                        fit: BoxFit.fitWidth)),
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
                  ))
            ],
          ),
        )
        //Stack(children: [
        //   Positioned(
        //       top: 238,
        //       left: 50,
        //       child: Container(
        //           width: 287,
        //           height: 251,
        //           decoration: const BoxDecoration(
        //             image: DecorationImage(
        //                 image: AssetImage('assets/images/SplashLogo.png'),
        //                 fit: BoxFit.fitWidth),
        //           ))),
        //   const Positioned(
        //       top: 400,
        //       left: 195,
        //       child: Text(
        //         'Video PLayer',
        //         textAlign: TextAlign.left,
        //         style: TextStyle(
        //             color: Color.fromRGBO(255, 255, 255, 1),
        //             fontFamily: 'Inter',
        //             fontSize: 16,
        //             letterSpacing: 0,
        //             fontWeight: FontWeight.normal,
        //             height: 1),
        //       )),
        // ]),
        );
  }

  ///////////////functions//////////////////////////
  //function fetching the videos
  fetchvideos() async {
    setState(() => isLoading = true);

    final albums = await PhotoManager.getAssetPathList(type: RequestType.video);
    // final albums= await PhotoManager.getAssetPathList(type: RequestType.all);
    final recentAlbum = albums.first;
    final assetCount = await recentAlbum.assetCountAsync;
    final recentAssets =
        await recentAlbum.getAssetListRange(start: 0, end: assetCount - 1);

    // dummyAssets.sort((a, b) => a.title!.compareTo(b.title!));
    // final List<AssetEntity> videoList = dummyAssets;

    setState(() {
      allFolderswithVideos = albums;
      allVideosList = recentAssets.toList();
      isLoading = false;
    });
    final dummyAssets = recentAssets;
    fetchVideosForAddVideoPage(dummyAssets: dummyAssets);
    gotoHome();
  }

  ////////////////////////////////////////////////////
  /////function to navigate home
  void gotoHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(
          assets: allVideosList, foldersWithVideos: allFolderswithVideos),
    ));
  }

  fetchVideosForAddVideoPage({required List<AssetEntity>? dummyAssets}) async {
    List<AssetEntity> myVideosData;
    dummyAssets!.sort((a, b) => a.title!.compareTo(b.title!));
    myVideosData = dummyAssets;

    setState(() {
      theAllVideosListFortheSelectionPage = myVideosData;
    });
    theAllShortVideos =
        await getLandscapeVideos(theAllVideosListFortheSelectionPage);
  }
}
