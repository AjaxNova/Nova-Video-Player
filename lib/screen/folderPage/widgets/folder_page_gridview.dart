import 'package:flutter/material.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:provider/provider.dart';

import '../../../functions/global_variables.dart';
import '../../videosFromFolders/videos_from_folders.dart';

class FolderPageGridView extends StatelessWidget {
  const FolderPageGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoDataModel>(
      builder: (context, value, child) {
        return GridView.builder(
          itemCount: value.allFoldersList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 3,
          ),
          itemBuilder: (context, index) {
            final folder = value.allFoldersList[index];

            return GestureDetector(
                onTap: () {
                  value.setAllVideosIntheFolders(folder);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VideosFromFolder(),
                    ),
                  );
                },
                child: InkWell(
                  child: ListView(
                    children: [
                      Icon(
                        Icons.folder,
                        color: colorWhite,
                        size: 90,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity / 3,
                        child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Text(
                            value.allFoldersList[index].name,
                            style: TextStyle(color: colorWhite),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}
