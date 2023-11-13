import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class HistoryProvider with ChangeNotifier {
  List<String> historyVideoIds = [];
  List<AssetEntity> historyVideosList = [];

  addTohistory(AssetEntity video) async {
    if (historyVideoIds.isEmpty) {
      final historyDb = await Hive.openBox<String>('videoHistory');
      await historyDb.add(video.id);
      historyVideosList.add(video);
      historyVideoIds.add(video.id);
      notifyListeners();
      log("added to history . .  .. . .. . ");
    } else {
      if (historyVideoIds.last != video.id) {
        final historyDb = await Hive.openBox<String>('videoHistory');
        await historyDb.add(video.id);
        historyVideosList.add(video);
        historyVideoIds.add(video.id);
        notifyListeners();
        log("added to history . .  .. . .. . ");
      }
    }
  }

  removeFromHistory({required AssetEntity video, required int index}) async {
    final historyDB = await Hive.openBox<String>('videoHistory');
    await historyDB.deleteAt(index);

    historyVideosList.removeAt(index);
    historyVideoIds.remove(video.id);
    notifyListeners();
  }

  clearHistory() async {
    final historyDB = await Hive.openBox<String>('videoHistory');
    historyDB.clear();
    historyVideoIds.clear();
    historyVideosList.clear();
    notifyListeners();
  }

  intiHistor({required BuildContext context}) async {
    final historyDB = await Hive.openBox<String>('videoHistory');
    historyVideoIds = historyDB.values.toList();
    final provi = Provider.of<VideoDataModel>(context, listen: false);
    final data = getAssetsFromIds(provi.allVideosList, historyVideoIds);
    historyVideosList.clear();
    historyVideosList.addAll(data);
    notifyListeners();
  }
}
