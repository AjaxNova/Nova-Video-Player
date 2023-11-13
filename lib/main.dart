import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nova_videoplayer/provider/favoriteProvider/favorite_provider.dart';
import 'package:nova_videoplayer/provider/historyprovider/history_provider.dart';
import 'package:nova_videoplayer/provider/home/home_button_provider.dart';
import 'package:nova_videoplayer/provider/playlistDbProvider/playlist_db_provider.dart';
import 'package:nova_videoplayer/provider/shortVideoProvider/short_video_provider.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/provider/watchLater/watch_later_provider.dart';
import 'package:nova_videoplayer/screen/splashScreenPage/splash_screen.dart';
import 'package:provider/provider.dart';

import 'functions/new_playlist_class.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Hive.isAdapterRegistered(PlaylistAdapter().typeId)) {
    Hive.registerAdapter(PlaylistAdapter());
  }
  await Hive.initFlutter();

  await Hive.openBox<String>('videoHistory');

  await Hive.openBox<String>('FavoriteDB');

  await Hive.openBox<Playlist>('playlistDb');

  await Hive.openBox<String>('videoHistory');

  await Hive.openBox<String>("watchLater");

  runApp(const Nova());
}

class Nova extends StatelessWidget {
  const Nova({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoDataModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeButtonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaylistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShortVideoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WatchlLaterProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
