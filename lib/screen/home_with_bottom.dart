import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/screen/all_videos.dart';
import 'package:nova_videoplayer/screen/folder_page.dart';
import 'package:nova_videoplayer/screen/newPlaylistPage/fav_and_playlist_select_page.dart';
import 'package:nova_videoplayer/screen/newPlaylistPage/shorts_page/shorts_try_two.dart';
import 'package:photo_manager/photo_manager.dart';
import '../settings/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.assets, required this.foldersWithVideos});
  final List<AssetPathEntity> foldersWithVideos;
  final List<AssetEntity> assets;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      AllVideosPage(
          assets: widget.assets, foldersWithVideos: widget.foldersWithVideos),
      FolderPage(foldersWithVideos: widget.foldersWithVideos),
      const PlaylistOrFavorite(),
      const SettingsScreen(),
      ShortsPageTry(
        shortVideos: theAllShortVideos,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(bodySmall: const TextStyle(color: Colors.yellow))),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorBlack,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: colorGreen,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library),
                label: 'All Videos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.folder),
                label: 'Folders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_play),
                label: 'Playlists',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tiktok),
                label: 'Shorts',
              ),
            ],
          ),
        ));
  }
}
