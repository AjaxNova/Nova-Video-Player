import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/screen/explorePage/favouritePage/favorite_videos_page.dart';
import 'package:nova_videoplayer/screen/explorePage/historyPage/history_page.dart';
import 'package:nova_videoplayer/screen/explorePage/playlistPage/add_new_playlist.dart';
import 'package:nova_videoplayer/screen/explorePage/watchLater/watch_later.dart';

class PlaylistOrFavorite extends StatelessWidget {
  const PlaylistOrFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        backgroundColor: colorBlack,
        title: const Text('Explore'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Divider(
              color: colorWhite,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Favorite',
                  style: TextStyle(color: colorWhite),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PlaylistPage(),
                  ));
                },
                title: Text(
                  'Playlist',
                  style: TextStyle(color: colorWhite),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ));
                },
                title: Text(
                  'History',
                  style: TextStyle(color: colorWhite),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WatchLaterPage(),
                  ));
                },
                title: Text(
                  'Watch Later',
                  style: TextStyle(color: colorWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
