import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/screen/video_player_page.dart';
import 'package:provider/provider.dart';

class AllVideosGridView extends StatelessWidget {
  const AllVideosGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoDataModel>(
      builder: (context, value, child) {
        return GridView.builder(
          //controller: _scrollController,
          padding: const EdgeInsets.all(8.0),
          itemCount: value.allVideosList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPLayerPage(
                      videoList: value.allVideosList,
                      initialIndex: index,
                    ),
                  ),
                );
              },
              child: GestureDetector(
                onLongPress: () {
                  ///implement the video preview
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FutureBuilder<Uint8List?>(
                      future: value.allVideosList[index].thumbnailData,
                      builder: (BuildContext context,
                          AsyncSnapshot<Uint8List?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox(
                                height: 120,
                                width: 150,
                                child: Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                )),
                          );
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.black,
                          );
                        }
                      },
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 145),
                        child: Text(
                          value.allVideosList[index].title ?? 'Unnamed',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
