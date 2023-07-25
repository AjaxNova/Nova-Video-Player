import 'package:flutter/material.dart';
import 'package:nova_videoplayer/provider/videoDataProvider/video_data_provider.dart';
import 'package:nova_videoplayer/widgets/search_delegate_function.dart';
import 'package:provider/provider.dart';

import '../functions/global_variables.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoDataModel>(
      builder: (context, value, child) {
        return Container(
          height: 58,
          margin: const EdgeInsets.only(top: 7),
          child: ListTile(
            leading: const Text(
              'NOVA ',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 26,
                  letterSpacing: 3),
            ),
            trailing: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    value.toggleView();
                    // _scrollController.jumpTo(0.0);
                    //  toggleView();
                  },
                  child: Icon(
                    value.isGridView ? Icons.list : Icons.grid_on,
                    color: colorWhite,
                    size: 22,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 13, left: 16),
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sort by'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () async {
                                    value.sortNameAsc();
                                    Navigator.of(context).pop('name_asc');
                                  },
                                  child: const Text('Name - Ascending'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () async {
                                    value.sortNameDes();
                                    Navigator.of(context).pop('name_desc');
                                  },
                                  child: const Text('Name - Descending'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () async {
                                    value.sortSizeAsc();
                                    Navigator.of(context).pop('size_asc');
                                  },
                                  child: const Text('Size - Ascending'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    value.sortSizeDes();

                                    Navigator.of(context).pop('size_desc');
                                  },
                                  child: const Text('Size - Descending'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    value.sortDurationAsc();

                                    Navigator.of(context).pop('duration_asc');
                                  },
                                  child: const Text('Duration - Ascending'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop('duration_desc');
                                  },
                                  child: const Text('Duration - Descending'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.format_line_spacing_sharp,
                      color: colorWhite,
                      size: 23,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: VideoSearchDelegate(
                            assets: value.allVideosList,
                            isGridView: value.isGridView));
                  },
                  child: Icon(
                    Icons.search,
                    color: colorWhite,
                    size: 23,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
