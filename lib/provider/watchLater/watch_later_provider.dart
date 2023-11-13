import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:photo_manager/photo_manager.dart';

class WatchlLaterProvider with ChangeNotifier {
  List<AssetEntity> watchLaterlist = [];
  initWatchLater(List<AssetEntity> allvideos) async {
    final laterBox = await Hive.openBox<String>("watchLater");
    watchLaterlist = getAssetsFromIds(allvideos, laterBox.values.toList());
  }

  addToWatchLater(AssetEntity video) async {
    final laterBox = await Hive.openBox<String>("watchLater");
    laterBox.add(video.id);
    watchLaterlist.add(video);
    notifyListeners();
    print("data added");
  }

  removeFromWatchLater({required int index}) async {
    final laterBox = await Hive.openBox<String>("watchLater");
    laterBox.deleteAt(index);
    watchLaterlist.removeAt(index);
    notifyListeners();
  }

  clearWatchingHistory() async {
    final laterBox = await Hive.openBox<String>("watchLater");
    laterBox.clear();
    watchLaterlist.clear();
    notifyListeners();
    laterBox.close();
  }
}
