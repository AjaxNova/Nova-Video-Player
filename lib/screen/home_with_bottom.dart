import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/provider/home/home_button_provider.dart';
import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen(
//       {super.key, required this.assets, required this.foldersWithVideos});
//   final List<AssetPathEntity> foldersWithVideos;
//   final List<AssetEntity> assets;
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _children = [
//     const AllVideosPage(),
//     const FolderPage(foldersWithVideos: []),
//     const PlaylistOrFavorite(),
//     const SettingsScreen(),
//     ShortsPageTry(
//       shortVideos: theAllShortVideos,
//     )
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _children[_currentIndex],
//         bottomNavigationBar: Theme(
//           data: Theme.of(context).copyWith(
//               canvasColor: Colors.black,
//               textTheme: Theme.of(context)
//                   .textTheme
//                   .copyWith(bodySmall: const TextStyle(color: Colors.yellow))),
//           child: BottomNavigationBar(
//             elevation: 0,
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: colorBlack,
//             currentIndex: _currentIndex,
//             onTap: (int index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             selectedItemColor: colorGreen,
//             unselectedItemColor: Colors.grey,
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.video_library),
//                 label: 'All Videos',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.folder),
//                 label: 'Folders',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.playlist_play),
//                 label: 'Playlists',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.settings),
//                 label: 'Settings',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.tiktok),
//                 label: 'Shorts',
//               ),
//             ],
//           ),
//         ));
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widLis = Provider.of<HomeButtonProvider>(context);

    return Consumer<HomeButtonProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: widLis.children[widLis.currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.black,
                textTheme: Theme.of(context).textTheme.copyWith(
                    bodySmall: const TextStyle(color: Colors.yellow))),
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: colorBlack,
              currentIndex: value.currentIndex,
              onTap: (int index) {
                value.setIndex(index);
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
                  label: 'Explore',
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
          ),
        );
      },
    );
  }
}
