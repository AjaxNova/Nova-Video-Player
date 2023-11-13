import 'package:flutter/material.dart';
import 'package:nova_videoplayer/provider/watchLater/watch_later_provider.dart';
import 'package:provider/provider.dart';

class WatchLaterPage extends StatelessWidget {
  const WatchLaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(),
          Expanded(
            child: Consumer<WatchlLaterProvider>(
              builder: (context, value, child) {
                if (value.watchLaterlist.isEmpty) {
                  return const Center(
                    child: Text("No data "),
                  );
                } else {
                  return ListView.builder(
                    itemCount: value.watchLaterlist.length,
                    itemBuilder: (context, index) {
                      final data = value.watchLaterlist[index];
                      return ListTile(title: Text(data.title.toString()));
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
