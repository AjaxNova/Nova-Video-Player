import 'package:flutter/material.dart';
import 'package:nova_videoplayer/screen/all_videos.dart';
import 'package:photo_manager/photo_manager.dart';

class VideoDataProvider with ChangeNotifier {
  List<AssetEntity> allVideosList = [];
  List<AssetPathEntity>? allFoldersList;

  fetchvideos(BuildContext context) async {
    // setState(() => isLoading = true);

    final albums = await PhotoManager.getAssetPathList(type: RequestType.video);
    final recentAlbum = albums.first;
    final assetCount = await recentAlbum.assetCountAsync;
    final recentAssets =
        await recentAlbum.getAssetListRange(start: 0, end: assetCount - 1);

    // dummyAssets.sort((a, b) => a.title!.compareTo(b.title!));
    // final List<AssetEntity> videoList = dummyAssets;
    allVideosList = recentAssets.toList();
    notifyListeners();
    allFoldersList = albums;
    notifyListeners();

    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const AllVideosPage(assets: [], foldersWithVideos: []),
      )),
    );

    // setState(() {
    //   allFolderswithVideos = albums;
    //   allVideosList = recentAssets.toList();
    //   isLoading = false;
    // });
    // final dummyAssets = recentAssets;
    // fetchVideosForAddVideoPage(dummyAssets: dummyAssets);
    // gotoHome();
  }
}
