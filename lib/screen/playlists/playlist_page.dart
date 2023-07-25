// // import 'package:flutter/material.dart';
// // import 'package:photo_manager/photo_manager.dart';

// // import '../database/database_functions.dart';

// // class PlayListPage extends StatelessWidget {
// //   const PlayListPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ValueListenableBuilder(
// //       valueListenable: favoriteListnotifier,
// //       builder:(BuildContext context, List<AssetEntity> allFavoriteVideos, Widget? child){

// //         return ListView.builder(
// //         itemBuilder: (context, index) {
// //                 final video=allFavoriteVideos[index];
// //                     return ListTile(

// //                     title:Text(video.title!) ,
// //                     subtitle: Text(video.relativePath.toString()),
// //                     trailing: Text(video.size.toString()),

// //                     );

// //                 },
// //         itemCount: allFavoriteVideos.length,
// //         );

// //       } ,
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:nova_videoplayer/functions/playlist_class.dart';
// import 'package:nova_videoplayer/screen/playlists/each_playlist_page.dart';
// import 'package:nova_videoplayer/screen/splash_screen.dart';

// class PlayListPage extends StatefulWidget {
//   const PlayListPage({super.key});

//   @override
//   State<PlayListPage> createState() => _PlayListPageState();
// }

// class _PlayListPageState extends State<PlayListPage> {

//  TextEditingController playlistNameController = TextEditingController();

//   late String playlistName;

//   @override
//   Widget build(BuildContext context) {
//     if (playListnotifier.value.isEmpty) {
//      return Scaffold(
//    body: SafeArea(
//   child:   Center(

//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,

//       children: [ElevatedButton(onPressed: (){

//         //   final newPlaylist=PlayListModel(playListName: 'asd', id: []);
//         // addToPlaylist(newPlaylist);
//         // setState(() {
//         // });
//             showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Add New Playlist"),
//           content: TextField(
//             controller: playlistNameController,
//             decoration: InputDecoration(hintText: "Enter Playlist Name"),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Save"),
//               onPressed: () {
//                  playlistName = playlistNameController.text;
//                 // Do something with the playlist name, such as save it to a database
//                    final newPlaylist=PlayListModel(playListName: playlistName);
//                 addToPlaylist(newPlaylist);
//                 setState(() {
//                 });

//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );

//       }, child: const Text('Add new Playlist')),

//         const Text('No videos Found ')

//       ],

//     ),

//   ),
// ),
//      );
//     }
//     return  Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: (){
//         playlistNameController.clear();

//                     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Add New Playlist"),
//           content: TextField(
//             controller: playlistNameController,
//             decoration: const InputDecoration(hintText: "Enter Playlist Name"),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("Cancel"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text("Save"),
//               onPressed: () {

//                  playlistName = playlistNameController.text;
//                 // Do something with the playlist name, such as save it to a database
//                    final newPlaylist=PlayListModel(playListName: playlistName);
//                 addToPlaylist(newPlaylist);
//                 playlistNameController.clear();
//                 setState(() {
//                 });

//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//       },child: const Text('add '),),
//       body: ValueListenableBuilder(
//         valueListenable: playListnotifier,
//         builder:(BuildContext context, List<PlayListModel> allPlaylists, Widget? child){

//           return ListView.builder(
//           itemBuilder: (context, index) {
//                   final playlist=allPlaylists[index];
//                       return ListTile(
//                         onTap: () {
//                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EachPLaylist(videoId: allPlaylists[index].id.value.toList(), playList: allPlaylists[index],),));
//                         },

//                       title:Text(playlist.playListName) ,

//                       );

//                   },
//           itemCount: allPlaylists.length,
//           );

//         } ,
//       ),
//     );
//   }
// }
