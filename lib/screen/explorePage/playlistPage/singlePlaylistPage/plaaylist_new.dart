// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:nova_videoplayer/functions/new_playlist_class.dart';
// import 'package:nova_videoplayer/provider/playlistDbProvider/playlist_db_provider.dart';
// import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:provider/provider.dart';

// class PlaylistDetailsPage extends StatefulWidget {
//   final Playlist playlist;
//   final int playlistKey;

//   const PlaylistDetailsPage(
//       {super.key, required this.playlist, required this.playlistKey});

//   @override
//   State<PlaylistDetailsPage> createState() => _PlaylistDetailsPageState();
// }

// class _PlaylistDetailsPageState extends State<PlaylistDetailsPage> {
//   late List<AssetEntity> _videos;
//   // late bool iconStatus;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVideos();
//   }

//   void _fetchVideos() async {
//     _videos = Provider.of<VideoDataModel>(context, listen: false).allVideosList;
//   }

//   void _showAddVideoDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Consumer<PlaylistProvider>(
//               builder: (context, value, child) {
//                 return AlertDialog(
//                   backgroundColor: Colors.blueGrey,
//                   title: const Text(
//                     'Add videos',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   content: SizedBox(
//                     width: double.maxFinite,
//                     child: ListView.builder(
//                       itemCount: _videos.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(color: colorWhite)),
//                           child: ListTile(
//                               leading: FutureBuilder<Uint8List?>(
//                                 future: _videos[index].thumbnailData,
//                                 builder: (BuildContext context,
//                                     AsyncSnapshot<Uint8List?> snapshot) {
//                                   if (snapshot.connectionState ==
//                                           ConnectionState.done &&
//                                       snapshot.data != null) {
//                                     return ClipRRect(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       child: SizedBox(
//                                           height: 40,
//                                           width: 50,
//                                           child: Image.memory(
//                                             snapshot.data!,
//                                             fit: BoxFit.cover,
//                                           )),
//                                     );
//                                   } else {
//                                     return ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                         child: const SizedBox(
//                                             height: 50,
//                                             width: 70,
//                                             child: Icon(
//                                               Icons.movie,
//                                               color: Colors.black,
//                                             )));
//                                   }
//                                 },
//                               ),
//                               title: Container(
//                                 margin: const EdgeInsets.only(bottom: 16),
//                                 child: Text(
//                                   _videos[index].title ?? 'Unnamed',
//                                   maxLines: 3,
//                                   style: const TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                               // onTap: () {
//                               //     Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) => VideoPLayerPage(
//                               //         videoList: widget.assets,
//                               //         initialIndex: index,
//                               //       ),
//                               //     ),
//                               //   );
//                               // },
//                               // subtitle: Text(durationToString(_videos[index].duration,),
//                               // style: const TextStyle(
//                               //   color: Colors.black
//                               // ),),
//                               trailing: Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: IconButton(
//                                     onPressed: !value
//                                             .playListList[widget.playlistKey]
//                                             .isValueIn(_videos[index].id)
//                                         ? () {
//                                             ///add function
//                                             videoAddPlaylist(_videos[index]);
//                                           }
//                                         : () {
//                                             videoDeleteFromPLayList(
//                                                 _videos[index]);
//                                           },
//                                     icon: Icon(!value
//                                             .playListList[widget.playlistKey]
//                                             .isValueIn(_videos[index].id)
//                                         ? Icons.add
//                                         : Icons.remove),
//                                   )
//                                   // !widget.playlist
//                                   //         .isValueIn(_videos[index].id)
//                                   //     ? IconButton(
//                                   //         onPressed: () {
//                                   //           if (widget.playlist.videoIds
//                                   //               .contains(_videos[index].id)) {}

//                                   //           setState(() {
//                                   //             ////////////////////////////////
//                                   //             videoAddPlaylist(_videos[index]);

//                                   //             PlaylistDb.playlistNotifiier
//                                   //                 .notifyListeners();
//                                   //           });
//                                   //         },
//                                   //         icon: const Icon(
//                                   //           Icons.add,
//                                   //           color: Colors.black,
//                                   //         ))
//                                   //     : IconButton(
//                                   //         onPressed: () {
//                                   //           setState(
//                                   //             () {
//                                   //               widget.playlist.deleteData(
//                                   //                   _videos[index].id);
//                                   //             },
//                                   //           );
//                                   //           const snackBar = SnackBar(
//                                   //             content: Text(
//                                   //               'Song deleted from playlist',
//                                   //               style: TextStyle(
//                                   //                   color: Colors.white),
//                                   //             ),
//                                   //             duration:
//                                   //                 Duration(milliseconds: 450),
//                                   //           );
//                                   //           ScaffoldMessenger.of(context)
//                                   //               .showSnackBar(snackBar);
//                                   //         },
//                                   //         icon: const Padding(
//                                   //           padding: EdgeInsets.only(bottom: 25),
//                                   //           child: Icon(
//                                   //             Icons.minimize,
//                                   //             color: Colors.white,
//                                   //           ),
//                                   //         ),
//                                   //       ),
//                                   )

//                               // InkWell(
//                               //   onTap: () {
//                               //     print('clicked');
//                               //        final video=widget.assets[index];
//                               //        FavoriteMenuButton(
//                               //       favoriteVideo: video,
//                               //        indexKey: index);
//                               //        print('object');
//                               //       // addToFavorites(video.id);
//                               //       // getOneAssetById(video.id);
//                               //    },
//                               //   child: Container(
//                               //     margin: const EdgeInsets.only(bottom: 16),
//                               //     child: const Icon(Icons.more_vert,color: Colors.white,)),
//                               // )
//                               ),
//                         );
//                         // ListTile(
//                         //   title: Text(_videos[index].title!),
//                         //   trailing: IconButton(
//                         //     icon: Icon(
//                         //       // widget.playlist.videoIdNotifier.value.contains(_videos[index].id)
//                         //       //     ? Icons.check_circle
//                         //       //  :
//                         //        Icons.add_circle,
//                         //     ),
//                         //     onPressed: () async{
//                         //       // final playlistDB=await Hive.openBox<Playlist>('playlist_db');
//                         //       // print('Box opened');
//                         //       // final playlist = playlistDB.values.firstWhere((p) => p.name == widget.playlist.name);
//                         //       // playlist.addOrRemoveVideo(_videos[index].id);
//                         //       // print('id added');
//                         //       // await playlistDB.put(playlist.uniqueId,playlist);
//                         //       // print('db updated');

//                         //       // await widget.playlist.addOrRemoveVideo(_videos[index].id);
//                         //       // await widget.playlist.addToTheAssetPLaylist(id: _videos[index].id);
//                         //       playListnotifier.notifyListeners();

//                         //       Navigator.pop(context);
//                         //     },
//                         //   ),
//                         // );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provi = Provider.of<VideoDataModel>(context);
//     late List<AssetEntity> videoPlaylist;
//     return Scaffold(
//       backgroundColor: colorBlack,
//       appBar: AppBar(
//         backgroundColor: colorBlack,
//         title: Text(widget.playlist.name),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 _showAddVideoDialog();
//                 //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoSelectionPage(playlist:widget.playlist ),));
//               },
//               icon: const Icon(Icons.add))
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ValueListenableBuilder(
//                 valueListenable: Hive.box<Playlist>('playlistDb').listenable(),
//                 builder: (BuildContext context, Box<Playlist> allPlaylistsz,
//                     Widget? child) {
//                   final thePlaylist = allPlaylistsz.values
//                       .toList()[widget.playlistKey]
//                       .videoIds;
//                   videoPlaylist =
//                       getAssetsFromIds(provi.allVideosList, thePlaylist);
//                   return videoPlaylist.isEmpty
//                       ? Center(
//                           child: Text(
//                             'No Video in this playlist',
//                             style: TextStyle(color: colorWhite),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemBuilder: (context, index) {
//                             //  final theVideoList = videoPlaylist;
//                             final theVideo = videoPlaylist[index];

//                             return ListTile(
//                               leading: FutureBuilder<Uint8List?>(
//                                 future: theVideo.thumbnailData,
//                                 builder: (BuildContext context,
//                                     AsyncSnapshot<Uint8List?> snapshot) {
//                                   if (snapshot.connectionState ==
//                                           ConnectionState.done &&
//                                       snapshot.data != null) {
//                                     return ClipRRect(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       child: SizedBox(
//                                           height: 50,
//                                           width: 70,
//                                           child: Image.memory(
//                                             snapshot.data!,
//                                             fit: BoxFit.cover,
//                                           )),
//                                     );
//                                   } else {
//                                     return ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                         child: const SizedBox(
//                                             height: 50,
//                                             width: 70,
//                                             child: Icon(
//                                               Icons.movie,
//                                               color: Colors.white,
//                                             )));
//                                   }
//                                 },
//                               ),
//                               title: Text(
//                                 theVideo.title!,
//                                 maxLines: 2,
//                                 style: TextStyle(color: colorWhite),
//                               ),
//                               subtitle: Text(
//                                 theVideo.relativePath.toString(),
//                                 maxLines: 1,
//                                 style: TextStyle(color: colorWhite),
//                               ),
//                               trailing: IconButton(
//                                 onPressed: () {
//                                   videoDeleteFromPLayList(theVideo);
//                                 },
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               onTap: () {
//                                 // Navigator.of(context).push(MaterialPageRoute(
//                                 //   builder: (context) => VideoPlayerPage(
//                                 //       videoList: theVideoList,
//                                 //       initialIndex: index),
//                                 // ));
//                               },
//                             );
//                           },
//                           itemCount: videoPlaylist.length,
//                         );
//                 }
//                 //(BuildContext context, List<AssetEntity> allMyPlaylistVideos, Widget? child) {

//                 //    return ListView.builder(
//                 //     itemBuilder: (context, index) {
//                 //       final myvideo=allMyPlaylistVideos[index];
//                 //       return ListTile(
//                 //         title: Text(myvideo.title!),
//                 //         subtitle: Text(myvideo.relativePath.toString()),
//                 //       );
//                 //     },
//                 //     itemCount: allMyPlaylistVideos.length,
//                 //     );
//                 // } ,
//                 ),
//             // child: ValueListenableBuilder(
//             //   valueListenable: playlistVideosNotifier,
//             //   builder: (BuildContext context, List<AssetEntity> playlistVideos, Widget? child){

//             //     return ListView.builder(
//             //       itemBuilder: (context, index) {
//             //         final myvideos=playlistVideos[index];
//             //         return ListTile(
//             //           title: Text(myvideos.title!),
//             //           subtitle: Text(myvideos.relativePath.toString()),
//             //         );
//             //       },
//             //       itemCount: playlistVideos.length,
//             //       );
//             //   })
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.add),
//       //   onPressed: () {
//       //      Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoSelectionPage(playlist:widget.playlist ),));
//       //   },
//       // ),
//     );
//   }

//   void videoAddPlaylist(AssetEntity data) {
//     final provi = Provider.of<PlaylistProvider>(context, listen: false);
//     widget.playlist.add(data.id);
//     provi.notifyIt();

//     const snackBar1 = SnackBar(
//         content: Text(
//       'video added to Playlist',
//       style: TextStyle(color: Colors.white),
//     ));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar1);
//   }

//   videoDeleteFromPLayList(AssetEntity data) {
//     final provi = Provider.of<PlaylistProvider>(context, listen: false);
//     provi.notifyIt();

//     widget.playlist.deleteData(data.id);
//     const snackBar1 = SnackBar(
//         content: Text(
//       'video removed from the list',
//       style: TextStyle(color: Colors.white),
//     ));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar1);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../../../functions/global_variables.dart';
import '../../../../functions/new_playlist_class.dart';
import '../../../../provider/playlistDbProvider/playlist_db_provider.dart';
import '../../../../provider/videoDataProvider/video_data_provider.dart';

//////////////////////////////////////////////

class SinglePlaylistPage extends StatelessWidget {
  final Playlist playlist;
  final int playlistkey;
  final List<AssetEntity> videos;
  const SinglePlaylistPage(
      {super.key,
      required this.playlist,
      required this.playlistkey,
      required this.videos});

  @override
  Widget build(BuildContext context) {
    final provi = Provider.of<VideoDataModel>(context);
    late List<AssetEntity> videoPlaylist;
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        backgroundColor: colorBlack,
        title: Text(playlist.name),
        actions: [
          IconButton(
              onPressed: () {
                _showAddVideoDialog(context, videos);
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoSelectionPage(playlist:widget.playlist ),));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: Hive.box<Playlist>('playlistDb').listenable(),
                builder: (BuildContext context, Box<Playlist> allPlaylistsz,
                    Widget? child) {
                  final thePlaylist =
                      allPlaylistsz.values.toList()[playlistkey].videoIds;
                  videoPlaylist =
                      getAssetsFromIds(provi.allVideosList, thePlaylist);
                  return videoPlaylist.isEmpty
                      ? Center(
                          child: Text(
                            'No Video in this playlist',
                            style: TextStyle(color: colorWhite),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            //  final theVideoList = videoPlaylist;
                            final theVideo = videoPlaylist[index];

                            return ListTile(
                              leading: FutureBuilder<Uint8List?>(
                                future: theVideo.thumbnailData,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List?> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox(
                                          height: 50,
                                          width: 70,
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                          )),
                                    );
                                  } else {
                                    return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                              title: Text(
                                theVideo.title!,
                                maxLines: 2,
                                style: TextStyle(color: colorWhite),
                              ),
                              subtitle: Text(
                                theVideo.relativePath.toString(),
                                maxLines: 1,
                                style: TextStyle(color: colorWhite),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  videoDeleteFromPLayList(
                                      theVideo, context, playlistkey);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {},
                            );
                          },
                          itemCount: videoPlaylist.length,
                        );
                }),
          ),
        ],
      ),
    );
  }

  videoDeleteFromPLayList(
    AssetEntity data,
    BuildContext context,
    int playlistKey,
  ) {
    final provi = Provider.of<PlaylistProvider>(context, listen: false);
    provi.notifyIt();

    playlist.deleteData(data.id);
    const snackBar1 = SnackBar(
        content: Text(
      'video removed from the list',
      style: TextStyle(color: Colors.white),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
  }

  void _showAddVideoDialog(context, videos) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return Consumer<PlaylistProvider>(
              builder: (context, value, child) {
                return AlertDialog(
                  backgroundColor: Colors.blueGrey,
                  title: const Text(
                    'Add videos',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: colorWhite)),
                          child: ListTile(
                              leading: FutureBuilder<Uint8List?>(
                                future: videos[index].thumbnailData,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List?> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox(
                                          height: 40,
                                          width: 50,
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                          )),
                                    );
                                  } else {
                                    return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: const SizedBox(
                                            height: 50,
                                            width: 70,
                                            child: Icon(
                                              Icons.movie,
                                              color: Colors.black,
                                            )));
                                  }
                                },
                              ),
                              title: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  videos[index].title ?? 'Unnamed',
                                  maxLines: 3,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              trailing: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    onPressed: !value.playListList[playlistkey]
                                            .isValueIn(videos[index].id)
                                        ? () {
                                            ///add function
                                            videoAddPlaylist(
                                                videos[index], context);
                                          }
                                        : () {
                                            videoDeleteFromPLayList(
                                                videos[index],
                                                context,
                                                playlistkey);
                                          },
                                    icon: Icon(!value.playListList[playlistkey]
                                            .isValueIn(videos[index].id)
                                        ? Icons.add
                                        : Icons.remove),
                                  ))),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void videoAddPlaylist(AssetEntity data, BuildContext context) {
    final provi = Provider.of<PlaylistProvider>(context, listen: false);
    playlist.add(data.id);
    provi.notifyIt();

    const snackBar1 = SnackBar(
        content: Text(
      'video added to Playlist',
      style: TextStyle(color: Colors.white),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
  }
}
