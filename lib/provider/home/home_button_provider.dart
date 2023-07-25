import 'package:flutter/material.dart';
import 'package:nova_videoplayer/screen/allVideosPage/all_videos.dart';
import 'package:nova_videoplayer/screen/explorePage/fav_and_playlist_select_page.dart';
import 'package:nova_videoplayer/screen/folderPage/folder_page.dart';
import 'package:nova_videoplayer/screen/newPlaylistPage/shorts_page/shorts_try_two.dart';
import 'package:nova_videoplayer/settings/settings_page.dart';

class HomeButtonProvider with ChangeNotifier {
  final List<Widget> children = [
    const AllVideosPage(),
    const FolderPage(),
    const PlaylistOrFavorite(),
    const SettingsScreen(),
    const ShortsPageTry(
      shortVideos: [],
    )
  ];

  int currentIndex = 0;
  setIndex(index) {
    currentIndex = index;
    notifyListeners();
  }
}
