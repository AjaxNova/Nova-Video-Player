import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_manager/photo_manager.dart';

class FavoriteProvider with ChangeNotifier {
  bool isInitialized = false;
  final favorBox = Hive.box<String>('FavoriteDB');
  List<AssetEntity> favoriteVideos = [];

  initialize(List<AssetEntity> videos) {
    for (AssetEntity video in videos) {
      if (isFavor(video)) {
        favoriteVideos.add(video);
      }
    }
    isInitialized = true;
  }

  isFavor(AssetEntity video) {
    if (favorBox.values.contains(video.id)) {
      return true;
    }
    return false;
  }

  add(AssetEntity video) async {
    favorBox.add(video.id);
    favoriteVideos.add(video);
    notifyListeners();
  }

  delete(String id) async {
    int deletekey = 0;
    if (!favorBox.values.contains(id)) {
      return;
    }
    final Map<dynamic, String> favorMap = favorBox.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    favorBox.delete(deletekey);
    favoriteVideos.removeWhere((song) => song.id == id);
    notifyListeners();
  }

  clear() async {
    favorBox.clear();
    favoriteVideos.clear();
    notifyListeners();
  }
}
