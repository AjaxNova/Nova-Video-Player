// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:photo_manager/photo_manager.dart';

// import '../functions/gobal_functions.dart';

// class VideosFromFolder extends StatefulWidget {
//   final AssetPathEntity folder;
//   const VideosFromFolder({super.key, required this.folder});

//   @override
//   State<VideosFromFolder> createState() => _VideosFromFolderState();
// }

// class _VideosFromFolderState extends State<VideosFromFolder> {
//   List<AssetEntity> _videos = [];
//   void _loadVideosInFolder() async {
//     List<AssetEntity> videos =
//         await widget.folder.getAssetListRange(start: 0, end: 10000);

//     setState(() {
//       _videos = videos;
//     });
//   }

import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/screen/allVideosPage/widget/all_videos_listview.dart';
import 'package:provider/provider.dart';

class VideosFromFolder extends StatelessWidget {
  const VideosFromFolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoDataModel>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: colorBlack,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(value.allVideosIntheFoldersTitle),
          ),
          body: value.allVideosIntheFolders.isEmpty
              ? const Center(
                  child: Text("No videos to load"),
                )
              : const ListviewAllVideos(pageType: "not"),
          // : ListView.builder(
          //     itemCount: value.allVideosIntheFolders.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         leading: FutureBuilder<Uint8List?>(
          //           future:
          //               value.allVideosIntheFolders[index].thumbnailData,
          //           builder: (BuildContext context,
          //               AsyncSnapshot<Uint8List?> snapshot) {
          //             if (snapshot.connectionState ==
          //                     ConnectionState.done &&
          //                 snapshot.data != null) {
          //               return ClipRRect(
          //                 borderRadius: BorderRadius.circular(8.0),
          //                 child: SizedBox(
          //                     height: 50,
          //                     width: 70,
          //                     child: Image.memory(
          //                       snapshot.data!,
          //                       fit: BoxFit.cover,
          //                     )),
          //               );
          //             } else {
          //               return ClipRRect(
          //                   borderRadius: BorderRadius.circular(8.0),
          //                   child: const SizedBox(
          //                       height: 50,
          //                       width: 70,
          //                       child: Icon(
          //                         Icons.movie,
          //                         color: Colors.white,
          //                       )));
          //             }
          //           },
          //         ),
          //         title: Container(
          //           margin: const EdgeInsets.only(bottom: 16),
          //           child: Text(
          //             value.allVideosIntheFolders[index].title ?? 'Unnamed',
          //             maxLines: 1,
          //             style: const TextStyle(color: Colors.white),
          //           ),
          //         ),
          //         onTap: () async {
          //           File? file =
          //               await value.allVideosIntheFolders[index].file;
          //           // ignore: use_build_context_synchronously
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => VideoPlayerWidget(
          //                 videos: value.allVideosIntheFolders,
          //                 initialIndex: index,
          //                 videoPlayerController:
          //                     VideoPlayerController.file(file!),
          //               ),
          //             ),
          //           );
          //         },
          //         subtitle: Wrap(
          //           children: [
          //             Text(
          //               durationToString(
          //                 value.allVideosIntheFolders[index].duration,
          //               ),
          //               style: const TextStyle(color: Colors.white),
          //             ),
          //           ],
          //         ),
          //         trailing: Container(
          //           margin: const EdgeInsets.only(bottom: 16),
          //           child: const Icon(
          //             Icons.more_vert,
          //             color: Colors.white,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
        );
      },
    );
  }
}
