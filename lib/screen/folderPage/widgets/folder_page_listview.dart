import 'package:flutter/material.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:provider/provider.dart';

import '../../videosFromFolders/videos_from_folders.dart';

class FolderPageListView extends StatelessWidget {
  const FolderPageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoDataModel>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.allFoldersList.length,
          itemBuilder: (context, index) {
            final folder = value.allFoldersList[index];
            return ListTile(
              title: Text(
                folder.name,
                style:
                    const TextStyle(fontFamily: 'Inter', color: Colors.white),
              ),
              subtitle:
                  // Text(folder.assetCountAsync.toString()),
                  FutureBuilder<int>(
                future: folder.assetCountAsync,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '${snapshot.data!} videos',
                      style: const TextStyle(color: Colors.white),
                    );
                  } else {
                    return const Text('');
                  }
                },
              ),
              onTap: () async {
                value.setAllVideosIntheFolders(folder);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VideosFromFolder()),
                );
              },
            );
          },
        );
      },
    );
  }
}
