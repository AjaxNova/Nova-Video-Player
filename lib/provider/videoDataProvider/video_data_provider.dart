import 'package:flutter/material.dart';
import 'package:nova_videoplayer/provider/favoriteProvider/favorite_provider.dart';
import 'package:nova_videoplayer/provider/historyprovider/history_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class VideoDataModel with ChangeNotifier {
  List<AssetEntity> allVideosList = [];
  List<AssetPathEntity> allFoldersList = [];

  bool isGridView = false;

  toggleView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  sortNameAsc() {
    allVideosList.sort((a, b) => a.title!.compareTo(b.title!));
    notifyListeners();
  }

  sortNameDes() {
    allVideosList.sort((a, b) => b.title!.compareTo(a.title!));
    notifyListeners();
  }

  sortSizeAsc() {
    allVideosList
        .sort((a, b) => b.size.toString().compareTo(a.size.toString()));
    notifyListeners();
  }

  sortSizeDes() {
    allVideosList
        .sort((a, b) => a.size.toString().compareTo(b.size.toString()));
    notifyListeners();
  }

  sortDurationAsc() {
    allVideosList.sort((a, b) => a.duration.compareTo(b.duration));
    notifyListeners();
  }

  sortDurationDes() {
    allVideosList.sort((a, b) => b.duration.compareTo(a.duration));
    notifyListeners();
  }

  Future<void> fetchVideoList(context) async {
    final albums = await PhotoManager.getAssetPathList(type: RequestType.video);
    // final albums= await PhotoManager.getAssetPathList(type: RequestType.all);
    final recentAlbum = albums.first;

    final assetCount = await recentAlbum.assetCountAsync;
    final recentAssets =
        await recentAlbum.getAssetListRange(start: 0, end: assetCount - 1);
    allFoldersList = albums;
    allVideosList = recentAssets.toList();
    Provider.of<FavoriteProvider>(context, listen: false)
        .initialize(recentAssets);
    Provider.of<HistoryProvider>(context, listen: false)
        .intiHistor(context: context);
    // Provider.of<HistoryProvider>(context, listen: false).initHistory();
    // dummyAssets.sort((a, b) => a.title!.compareTo(b.title!));
    // final List<AssetEntity> videoList = dummyAssets;

    // setState(() {
    //   allFolderswithVideos = albums;
    //   allVideosList = recentAssets.toList();
    //   isLoading = false;

    // });
    // final dummyAssets = recentAssets;
    // fetchVideosForAddVideoPage(dummyAssets: dummyAssets);
    // gotoHome();
  }

  List<AssetEntity> allVideosIntheFolders = [];
  String allVideosIntheFoldersTitle = "UnNamed";
  setAllVideosIntheFolders(AssetPathEntity folder) async {
    int count = await folder.assetCountAsync;
    if (folder.name == "Recent") {
      count = count - 1;
    }
    allVideosIntheFolders =
        await folder.getAssetListRange(start: 0, end: count);
    allVideosIntheFoldersTitle = folder.name;
    notifyListeners();
  }
}
