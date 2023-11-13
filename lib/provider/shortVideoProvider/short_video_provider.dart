import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ShortVideoProvider with ChangeNotifier {
  List<AssetEntity> allShortVideos = [];
  int pageCounter = 0;

  incrementPage(int index) {
    pageCounter = index;
    notifyListeners();
  }

  getLandscapeVideos(List<AssetEntity> videos) async {
    final List<AssetEntity> result = [];

    for (final video in videos) {
      final duration = video.videoDuration;
      final aspectRatio = video.width / video.height;
      if (aspectRatio > 1 &&
          (duration < const Duration(seconds: 32)) &&
          duration > const Duration(seconds: 4)) {
        result.add(video);
      }
    }
    result.shuffle();
    allShortVideos = result;
  }
}
