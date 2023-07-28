import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../functions/favoritedb.dart';
import '../../functions/gobal_functions.dart';
import '../../functions/new_playlist_class.dart';
import '../../functions/new_playlist_db_functions.dart';

class FavoriteMenuButton extends StatefulWidget {
  const FavoriteMenuButton(
      {super.key, required this.favoriteVideo, required this.indexKey});
  final AssetEntity favoriteVideo;
  final int indexKey;
  @override
  State<FavoriteMenuButton> createState() => _FavoriteMenuButtonState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

class _FavoriteMenuButtonState extends State<FavoriteMenuButton> {
  late bool pather;
  late bool namer;
  @override
  Widget build(BuildContext context) {
    if (widget.favoriteVideo.title!.length < 20) {
      setState(() {
        namer = false;
      });
    } else {
      setState(() {
        namer = true;
      });
    }

    if (widget.favoriteVideo.relativePath!.length < 20) {
      setState(() {
        pather = false;
      });
    } else {
      setState(() {
        pather = true;
      });
    }
    return ValueListenableBuilder(
      valueListenable: FavoriteDb.favoriteVideos,
      builder:
          (BuildContext ctx, List<AssetEntity> favoriteVideos, Widget? child) {
        return PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                  FavoriteDb.isFavor(widget.favoriteVideo)
                      ? 'Remove from favourites'
                      : 'Add to favourite',
                  style: const TextStyle(color: Colors.black, fontSize: 13)),
              onTap: () {
                if (FavoriteDb.isFavor(widget.favoriteVideo)) {
                  FavoriteDb.delete(widget.favoriteVideo.id);
                  const snackBar = SnackBar(
                    content: Text('Removed From Favorite'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  FavoriteDb.add(widget.favoriteVideo);
                  const snackBar = SnackBar(
                    content: Text('video Added to Favorite'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                FavoriteDb.favoriteVideos.notifyListeners();
              },
            ),
            const PopupMenuItem(
                value: 2,
                child: Text(
                  'Add to playlists',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                )),
            const PopupMenuItem(
                value: 3,
                child: Text(
                  'Video Details',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ))
          ],
          onSelected: (value) {
            if (value == 2) {
              showPlaylistdialog(context);
            }
            if (value == 3) {
              showDetailsDialogue(context);
            }
          },

          // color: Color.fromARGB(255, 37, 5, 92),
          elevation: 2,
        );
      },
    );
  }

  showPlaylistdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text(
              "choose your playlist",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Playlist>('playlistDb').listenable(),
                  builder: (BuildContext context, Box<Playlist> videoList,
                      Widget? child) {
                    return Hive.box<Playlist>('playlistDb').isEmpty
                        ? Center(
                            child: Stack(
                              children: const [
                                Positioned(
                                  right: 30,
                                  left: 30,
                                  bottom: 50,
                                  child: Text('No Playlist found!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: videoList.length,
                            itemBuilder: (context, index) {
                              final data = videoList.values.toList()[index];

                              return Card(
                                color: colorBlack,
                                shadowColor: colorBlack,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: Text(
                                    data.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    await songAddToPlaylist(
                                        widget.favoriteVideo, data, data.name);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    newplaylist(context, _formKey);
                  },
                  child: const Text(
                    'New Playlist',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          );
        });
  }

  songAddToPlaylist(AssetEntity data, Playlist datas, String name) async {
    if (!datas.isValueIn(data.id)) {
      datas.add(data.id);
      final snackbar1 = SnackBar(
          duration: const Duration(milliseconds: 850),
          backgroundColor: Colors.black,
          content: Text(
            'video added to $name',
            style: const TextStyle(color: Colors.greenAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar1);
    } else {
      final snackbar2 = SnackBar(
          duration: const Duration(milliseconds: 850),
          backgroundColor: Colors.black,
          content: Text(
            'video already in $name',
            style: const TextStyle(color: Colors.redAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar2);
    }
  }

  Future newplaylist(BuildContext context, formKey) {
    return showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
        children: [
          const SimpleDialogOption(
            child: Text(
              'New to Playlist',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
              key: formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                maxLength: 15,
                decoration: InputDecoration(
                    counterStyle: const TextStyle(
                      color: Colors.white,
                    ),
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
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveButtonPressed(context);
                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showDetailsDialogue(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              "All Details",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: SizedBox(
              height: 300,
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Name :"),
                          namer
                              ? Text(
                                  widget.favoriteVideo.title
                                      .toString()
                                      .substring(0, 20),
                                  overflow: TextOverflow.fade,
                                )
                              : Text(widget.favoriteVideo.title.toString())
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Path :"),
                          pather
                              ? Text(
                                  widget.favoriteVideo.relativePath
                                      .toString()
                                      .substring(0, 20),
                                  overflow: TextOverflow.fade,
                                )
                              : Text(
                                  widget.favoriteVideo.relativePath.toString())
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Duration :"),
                          Text(
                            durationToString(widget.favoriteVideo.duration),
                            overflow: TextOverflow.fade,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Size :"),
                          Text(
                            widget.favoriteVideo.size.toString(),
                            overflow: TextOverflow.fade,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> saveButtonPressed(context) async {
    final name = nameController.text.trim();
    final music = Playlist(name: name, videoIds: []);
    final datas =
        PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
    if (name.isEmpty) {
      return;
    } else if (datas.contains(music.name)) {
      const snackbar3 = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Colors.black,
          content: Text(
            'playlist already exist',
            style: TextStyle(color: Colors.redAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar3);
      Navigator.of(context).pop();
    } else {
      PlaylistDb.addPlaylist(music);
      const snackbar4 = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Colors.black,
          content: Text(
            'playlist created successfully',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar4);
      Navigator.pop(context);
      nameController.clear();
    }
  }
}
