import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/new_playlist_db_functions.dart';
import 'package:nova_videoplayer/provider/playlistDbProvider/playlist_db_provider.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/screen/explorePage/playlistPage/singlePlaylistPage/plaaylist_new.dart';
import 'package:provider/provider.dart';

import '../../../functions/global_variables.dart';
import '../../../functions/new_playlist_class.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final TextEditingController _playlistNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _playlistNameController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        backgroundColor: colorBlack,
        title: const Text('Playlists'),
        actions: [
          Consumer<PlaylistProvider>(
            builder: (context, value, child) {
              return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: value.playListList.isEmpty
                      ? const SizedBox()
                      : IconButton(
                          icon: Icon(color: colorWhite, Icons.add),
                          onPressed: () {
                            addNewPLaylistMethod(context);
                          }));
            },
          )
        ],
      ),
      body: Consumer<PlaylistProvider>(
        //valueListenable: Hive.box<Playlist>('playlistDb').listenable(),
        builder: (context, values, child) {
          final videos =
              Provider.of<VideoDataModel>(context, listen: false).allVideosList;
          return values.playListList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No playlist Found',
                        style: TextStyle(color: colorWhite),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorGreen),
                          onPressed: () {
                            addNewPLaylistMethod(context);
                          },
                          child: const Text('Add new playlist')),
                    ],
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final currentPlaylist = values.playListList.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SinglePlaylistPage(
                              playlist: currentPlaylist,
                              playlistkey: index,
                              videos: videos,
                            ),
                          ));
                        },
                        title: Text(
                          currentPlaylist.name,
                          style: TextStyle(color: colorWhite),
                        ),
                        subtitle: SizedBox(
                            height: 30,
                            child: Text(
                                '${currentPlaylist.videoIds.length.toString()} videos',
                                style: TextStyle(color: colorWhite))),
                        trailing: PopupMenuButton(
                          color: colorWhite,
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Text(
                                'delete',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                          onSelected: (value) {
                            if (value == 1) {
                              editPlaylistName(context, currentPlaylist, index);
                            } else if (value == 2) {
                              deletePlaylist(
                                  context, values.playListList, index);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: values.playListList.length,
                );
        },
      ),
    );
  }

  Future<dynamic> addNewPLaylistMethod(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            return AlertDialog(
              title: const Text('New Playlist'),
              content: TextField(
                controller: _playlistNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter playlist name',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    String name = _playlistNameController.text.trim();
                    final newPlaylist = Playlist(name: name, videoIds: []);
                    final datas = PlaylistDb.playlistDb.values
                        .map((e) => e.name.trim())
                        .toList();
                    if (name.isNotEmpty) {
                      if (datas.contains(newPlaylist.name)) {
                      } else {
                        value.addNewPlaylist(newPlaylist);
                        // PlaylistDb.addPlaylist(newPlaylist);
                      }
                      //  playListnotifier.value.add(playlist);
                      //  playListnotifier.notifyListeners();
                      _playlistNameController.clear();
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
                TextButton(
                  onPressed: () {
                    _playlistNameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

TextEditingController nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Future<dynamic> editPlaylistName(
    BuildContext context, Playlist data, int index) {
  nameController = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (context) {
      final provi = Provider.of<PlaylistProvider>(context);

      return SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // backgroundColor: Color.fromARGB(255, 52, 6, 105),
        backgroundColor: Colors.indigoAccent.shade100,
        children: [
          SimpleDialogOption(
            child: Text(
              "Edit Playlist ${data.name}",
              style: TextStyle(
                  color: colorBlack, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
              key: _formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                maxLength: 15,
                decoration: InputDecoration(
                    counterStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.white.withOpacity(0.7),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.only(left: 15, top: 5)),
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your playlist name";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController.clear();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      return;
                    } else {
                      final playlistName = Playlist(
                          name: name,
                          videoIds: provi.playListList[index].videoIds);

                      provi.editList(index, playlistName);
                      // PlaylistDb.editList(index, playlistName);
                    }
                    nameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> deletePlaylist(
    BuildContext context, List<Playlist> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      final provi = Provider.of<PlaylistProvider>(context, listen: false);
      return AlertDialog(
        // backgroundColor: Colors.indigoAccent.shade100,
        title: const Text(
          'Delete Playlist',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.black,
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(color: colorBlack),
            ),
          ),
          TextButton(
            onPressed: () async {
              await provi.deletePlaylist(index).then(
                (value) {
                  Navigator.of(context).pop();
                  const snackBar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Playlist is deleted',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(milliseconds: 350),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              );
            },
            child: Text('Yes', style: TextStyle(color: colorBlack)),
          ),
        ],
      );
    },
  );
}
