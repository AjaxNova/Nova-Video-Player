import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/provider/favoriteProvider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBlack,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Favourite Videos',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Consumer<FavoriteProvider>(
                        builder: (context, value, child) {
                      if (value.favoriteVideos.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 70, left: 10),
                          child: Text(
                            'No Favorite Videos',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: ListView.builder(
                              itemBuilder: ((context, index) {
                                final video = value.favoriteVideos[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  child: ListTile(
                                    iconColor: Colors.white,
                                    leading: FutureBuilder<Uint8List?>(
                                      future: video.thumbnailData,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Uint8List?> snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.data != null) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                      video.title!,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      video.relativePath.toString(),
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          color: Colors.blueGrey),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.heart_broken),
                                      onPressed: () {
                                        value.delete(video.id);
                                        // FavoriteDb.favoriteVideos
                                        //     .notifyListeners();
                                        // FavoriteDb.delete(
                                        //     favoriteData[index].id);
                                        const snackbar = SnackBar(
                                          content: Text(
                                            'Video Removed From  Favourites',
                                          ),
                                          duration: Duration(seconds: 1),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      },
                                    ),
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       VideoPlayerPage(
                                      //           videoList:
                                      //               favoriteData,
                                      //           initialIndex:
                                      //               index),
                                      // ));
                                    },
                                  ),
                                );
                              }),
                              itemCount: value.favoriteVideos.length,
                            ),
                          ),
                        );
                      }
                    }),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/favoriteProvider/favorite_provider.dart';

// class FavouriteScreen extends StatelessWidget {
//   const FavouriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorBlack,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                     const Text(
//                       'Favourite Videos',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 50,
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Consumer<FavoriteProvider>(
//                   builder: (context, value, child) {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: value.favoriteVideos.length,
//                         itemBuilder: (context, index) {
//                           final video = value.favoriteVideos[index];
//                           if (value.favoriteVideos.isEmpty) {
//                             return const Text(
//                               'No Favorite Videos',
//                               style: TextStyle(color: Colors.white),
//                             );
//                           } else {
//                             return Padding(
//                               padding: const EdgeInsets.only(left: 6, right: 6),
//                               child: ListTile(
//                                 iconColor: Colors.white,
//                                 leading: FutureBuilder<Uint8List?>(
//                                   future: video.thumbnailData,
//                                   builder: (BuildContext context,
//                                       AsyncSnapshot<Uint8List?> snapshot) {
//                                     if (snapshot.connectionState ==
//                                             ConnectionState.done &&
//                                         snapshot.data != null) {
//                                       return ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                         child: SizedBox(
//                                             height: 50,
//                                             width: 70,
//                                             child: Image.memory(
//                                               snapshot.data!,
//                                               fit: BoxFit.cover,
//                                             )),
//                                       );
//                                     } else {
//                                       return ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                           child: const SizedBox(
//                                               height: 50,
//                                               width: 70,
//                                               child: Icon(
//                                                 Icons.movie,
//                                                 color: Colors.white,
//                                               )));
//                                     }
//                                   },
//                                 ),
//                                 title: Text(
//                                   video.title!,
//                                   style: const TextStyle(
//                                       overflow: TextOverflow.ellipsis,
//                                       color: Colors.white),
//                                 ),
//                                 subtitle: Text(
//                                   video.relativePath.toString(),
//                                   style: const TextStyle(
//                                       overflow: TextOverflow.ellipsis,
//                                       fontSize: 12,
//                                       color: Colors.blueGrey),
//                                 ),
//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.heart_broken),
//                                   onPressed: () {
//                                     value.delete(video.id);
//                                     // FavoriteDb.delete(
//                                     //     favoriteData[index].id);
//                                     const snackbar = SnackBar(
//                                       content: Text(
//                                         'Video Removed From  Favourites',
//                                       ),
//                                       duration: Duration(seconds: 1),
//                                     );
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackbar);
//                                   },
//                                 ),
//                                 onTap: () {
//                                   // Navigator.of(context)
//                                   //     .push(MaterialPageRoute(
//                                   //   builder: (context) =>
//                                   //       VideoPlayerPage(
//                                   //           videoList:
//                                   //               favoriteData,
//                                   //           initialIndex:
//                                   //               index),
//                                   // ));
//                                 },
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     );
//                   },
//                   // ValueListenableBuilder(
//                   //   valueListenable: FavoriteDb.favoriteVideos,
//                   //   builder: (BuildContext ctx,
//                   //       List<AssetEntity> favoriteData, Widget? child) {
//                   //     if (favoriteData.isEmpty) {
//                   //       return const Padding(
//                   //         padding: EdgeInsets.only(top: 70, left: 10),
//                   //         child: Text(
//                   //           'No Favorite Videos',
//                   //           style: TextStyle(color: Colors.white),
//                   //         ),
//                   //       );
//                   //     }
//                   // else {
//                   //       return Padding(
//                   //         padding: const EdgeInsets.all(8.0),
//                   //         child: SizedBox(
//                   //             height: 400,
//                   //             width: double.infinity,
//                   //             child: ListView.builder(
//                   //               itemBuilder: ((context, index) {
//                   //                 return Padding(
//                   //                   padding: const EdgeInsets.only(
//                   //                       left: 6, right: 6),
//                   //                   child: ListTile(
//                   //                     iconColor: Colors.white,
//                   //                     leading: FutureBuilder<Uint8List?>(
//                   //                       future: favoriteData[index]
//                   //                           .thumbnailData,
//                   //                       builder: (BuildContext context,
//                   //                           AsyncSnapshot<Uint8List?>
//                   //                               snapshot) {
//                   //                         if (snapshot.connectionState ==
//                   //                                 ConnectionState.done &&
//                   //                             snapshot.data != null) {
//                   //                           return ClipRRect(
//                   //                             borderRadius:
//                   //                                 BorderRadius.circular(
//                   //                                     8.0),
//                   //                             child: SizedBox(
//                   //                                 height: 50,
//                   //                                 width: 70,
//                   //                                 child: Image.memory(
//                   //                                   snapshot.data!,
//                   //                                   fit: BoxFit.cover,
//                   //                                 )),
//                   //                           );
//                   //                         } else {
//                   //                           return ClipRRect(
//                   //                               borderRadius:
//                   //                                   BorderRadius.circular(
//                   //                                       8.0),
//                   //                               child: const SizedBox(
//                   //                                   height: 50,
//                   //                                   width: 70,
//                   //                                   child: Icon(
//                   //                                     Icons.movie,
//                   //                                     color: Colors.white,
//                   //                                   )));
//                   //                         }
//                   //                       },
//                   //                     ),
//                   //                     title: Text(
//                   //                       favoriteData[index].title!,
//                   //                       style: const TextStyle(
//                   //                           overflow: TextOverflow.ellipsis,
//                   //                           color: Colors.white),
//                   //                     ),
//                   //                     subtitle: Text(
//                   //                       favoriteData[index]
//                   //                           .relativePath
//                   //                           .toString(),
//                   //                       style: const TextStyle(
//                   //                           overflow: TextOverflow.ellipsis,
//                   //                           fontSize: 12,
//                   //                           color: Colors.blueGrey),
//                   //                     ),
//                   //                     trailing: IconButton(
//                   //                       icon:
//                   //                           const Icon(Icons.heart_broken),
//                   //                       onPressed: () {
//                   //                         FavoriteDb.favoriteVideos
//                   //                             .notifyListeners();
//                   //                         FavoriteDb.delete(
//                   //                             favoriteData[index].id);
//                   //                         const snackbar = SnackBar(
//                   //                           content: Text(
//                   //                             'Video Removed From  Favourites',
//                   //                           ),
//                   //                           duration: Duration(seconds: 1),
//                   //                         );
//                   //                         ScaffoldMessenger.of(context)
//                   //                             .showSnackBar(snackbar);
//                   //                       },
//                   //                     ),
//                   //                     onTap: () {
//                   //                       // Navigator.of(context)
//                   //                       //     .push(MaterialPageRoute(
//                   //                       //   builder: (context) =>
//                   //                       //       VideoPlayerPage(
//                   //                       //           videoList:
//                   //                       //               favoriteData,
//                   //                       //           initialIndex:
//                   //                       //               index),
//                   //                       // ));
//                   //                     },
//                   //                   ),
//                   //                 );
//                   //               }
//                   // ),
//                   //               itemCount: favoriteData.length,
//                   //             )),
//                   //       );
//                   //     }
//                   //   },
//                   // ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
