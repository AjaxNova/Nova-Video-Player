// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_videoplayer/functions/gobal_functions.dart';
// import 'package:nova_videoplayer/provider/favoriteProvider/favorite_provider.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/screen/video_player_page.dart';
import 'package:provider/provider.dart';

import 'fav_and_playlist_dialogurbox.dart';

class ListviewAllVideos extends StatelessWidget {
  const ListviewAllVideos({super.key, required this.pageType});

  final String pageType;

  @override
  Widget build(BuildContext context) {
    // final provi = Provider.of<FavoriteProvider>(context, listen: false);
    return Consumer<VideoDataModel>(
      builder: (context, value, child) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
              height: 1,
            );
          },
          itemCount: pageType == "all"
              ? value.allVideosList.length
              : value.allVideosIntheFolders.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: FutureBuilder<Uint8List?>(
                  future: pageType == "all"
                      ? value.allVideosList[index].thumbnailData
                      : value.allVideosIntheFolders[index].thumbnailData,
                  builder: (BuildContext context,
                      AsyncSnapshot<Uint8List?> snapshot) {
                    // if (!FavoriteDb.isInitialized) {
                    //   // pageType == "all"
                    //   provi.initialize(value
                    //       .allVideosList); //FavoriteDb.initialize(value.allVideosList)
                    //   // : provi.initialize(videos) FavoriteDb.initialize(value.allVideosIntheFolders);
                    // }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: SizedBox(
                                height: 80,
                                width: 90,
                                child: Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Positioned(
                            top: 34,
                            bottom: 1,
                            right: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.6),
                                  ],
                                ),
                              ),
                              child: Text(
                                durationToString(pageType == "all"
                                    ? value.allVideosList[index].duration
                                    : value
                                        .allVideosIntheFolders[index].duration),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: const SizedBox(
                              height: 50,
                              width: 70,
                              child: Icon(
                                Icons.movie,
                                color: Colors.white,
                              )));
                    }
                  },
                ),
                title: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    pageType == "all"
                        ? value.allVideosList[index].title ?? 'Unnamed'
                        : value.allVideosIntheFolders[index].title ?? 'Unnamed',
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () async {
                  // final File? file = pageType == "all"
                  //     ? await value.allVideosList[index].file
                  //     : await value.allVideosIntheFolders[index].file;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPLayerPage(
                        videoList: pageType == "all"
                            ? value.allVideosList
                            : value.allVideosIntheFolders,
                        // videoList: value.allVideosList,
                        initialIndex: index,
                        // aspectRatio: value.allVideosList[index].height /
                        //     value.allVideosList[index].width,
                        // chewieeController: ChewieController(
                        //     autoPlay: true,
                        //     showOptions: true,
                        //     allowPlaybackSpeedChanging: true,
                        //     zoomAndPan: true,
                        //     materialProgressColors: ChewieProgressColors(
                        //       playedColor: Colors.orange,
                        //       handleColor: colorGreen,
                        //       bufferedColor: Colors.transparent,
                        //       backgroundColor: Colors.black,
                        //     ),
                        //     videoPlayerController:
                        //         VideoPlayerController.file(file!),
                        //     autoInitialize: true,
                        //     // aspectRatio: 16 / 9,
                        //     looping: true,
                        //     showControls: true, // We'll use custom controls
                        //     fullScreenByDefault: true),
                        // videoPlayerController: VideoPlayerController.file(file),
                      ),
                    ),
                  );
                },
                subtitle: Text(
                  pageType == "all"
                      ? value.allVideosList[index].relativePath.toString()
                      : value.allVideosIntheFolders[index].relativePath
                          .toString(),
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white30),
                ),
                trailing: FavoriteMenuButton(
                    favoriteVideo: pageType == "all"
                        ? value.allVideosList[index]
                        : value.allVideosIntheFolders[index],
                    indexKey: index)

                // InkWell(
                //   onTap: () {
                //     print('clicked');
                //        final video=startSong[index];
                //        FavoriteMenuButton(
                //       favoriteVideo: video,
                //        indexKey: index);
                //        print('object');
                //       // addToFavorites(video.id);
                //       // getOneAssetById(video.id);
                //    },
                //   child: Container(
                //     margin: const EdgeInsets.only(bottom: 16),
                //     child: const Icon(Icons.more_vert,color: Colors.white,)),
                // )
                );
          },
        );
      },
    );
  }
}
