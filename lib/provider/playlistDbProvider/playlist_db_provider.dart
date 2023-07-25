// import 'package:flutter/cupertino.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:nova_videoplayer/functions/new_playlist_class.dart';

// class PlaylistDb {
//   static ValueNotifier<List<Playlist>> playlistNotifiier = ValueNotifier([]);
//   static final playlistDb = Hive.box<Playlist>('playlistDb');

//   static Future<void> addPlaylist(Playlist value) async {
//     final playlistDb = Hive.box<Playlist>('playlistDb');
//     await playlistDb.add(value);
//     playlistNotifiier.value.add(value);
//   }

//   static Future<void> getAllPlaylist() async {
//     final playlistDb = Hive.box<Playlist>('playlistDb');
//     playlistNotifiier.value.clear();
//     playlistNotifiier.value.addAll(playlistDb.values);
//     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
//     playlistNotifiier.notifyListeners();
//   }

//   static Future<void> deletePlaylist(int index) async {
//     final playlistDb = Hive.box<Playlist>('playlistDb');
//     await playlistDb.deleteAt(index);
//     getAllPlaylist();
//   }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nova_videoplayer/functions/new_playlist_class.dart';

class PlaylistProvider with ChangeNotifier {
  List<Playlist> playListList = [];

  notifyIt() {
    notifyListeners();
  }

  fetchAllPlayList() async {
    await Hive.openBox<Playlist>('playlist_db');
    final box = Hive.box<Playlist>('playlistDb').values.toList();
    playListList.clear();
    playListList.addAll(box);
    log("this is the playlist list = == = = = $playListList");
    notifyListeners();
  }

  addOrRemoveVideosFromPLaylist(
      String videoId, Playlist currentPlaylist, int currentIndex) {
    currentPlaylist.addOrRemoveVideo(videoId);
  }

  addVideoToPLayList(
      {required Playlist playlist,
      required int playlistIndex,
      required String videoId,
      required BuildContext context}) async {
    if (!playListList[playlistIndex].videoIds.contains(videoId)) {
      final box = Hive.box<Playlist>('playlistDb').values.toList();
      box[playlistIndex].videoIds.add(videoId);

      playListList[playlistIndex].videoIds.add(videoId);
      notifyListeners();
      const snackBar1 = SnackBar(
          content: Text(
        'video added to Playlist',
        style: TextStyle(color: Colors.white),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    } else {
      const snackBar1 = SnackBar(
          content: Text(
        'video already in the playList',
        style: TextStyle(color: Colors.white),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }
  }

  initilaizePlayListVideos(Playlist playlist) {}

  Future<void> addNewPlaylist(Playlist playlist) async {
    final playlistDb = Hive.box<Playlist>('playlistDb');
    await playlistDb.add(playlist);
    playListList.add(playlist);
    notifyListeners();
  }

  Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<Playlist>('playlistDb');
    await playlistDb.deleteAt(index);
    playListList.removeAt(index);
    notifyListeners();
  }

  Future<void> editList(int index, Playlist value) async {
    final playlistDb = Hive.box<Playlist>('playlistDb');
    await playlistDb.putAt(index, value);
    playListList[index] = value;
    notifyListeners();
  }

  // Future<void> editPLaylist(
  //     {required int index, required String playlistName}) async {
  //   final playlistDb = Hive.box<Playlist>('playlistDb');
  //   playlistDb.values.toList()[index].name = playlistName;
  //   playListList[index].name = playlistName;
  //   notifyListeners();
  // }
}
