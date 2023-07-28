// import 'package:flutter/material.dart';
// import 'package:nova_videoplayer/functions/global_variables.dart';
// import 'package:nova_videoplayer/functions/playlist_class.dart';
// import 'package:nova_videoplayer/screen/playlists/video_selection_screen.dart';

// class EachPLaylist extends StatefulWidget {
//       EachPLaylist({required this.playList,required this.videoId, super.key});

//    final PlayListModel playList;
//    late List<String>videoId;
//     //  ValueNotifier<List<String>>videoIds=ValueNotifier([]);

//   @override
//   State<EachPLaylist> createState() => _EachPLaylistState();
// }

// class _EachPLaylistState extends State<EachPLaylist> {

//     bool status=false;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.videoId.isEmpty) {

//      setState(() {
//        status==false;
//      });
//     }else{
//       widget.videoId=widget.videoId;
//       setState(() {
//         status=true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (status==true) {
//     return  Scaffold(

//     body: ValueListenableBuilder(
//       valueListenable:widget.playList.id,
//       builder:(BuildContext context, List<String> allIdsList, Widget? child){
//         return ListView.builder(itemBuilder: (context, index) {
//        return ListTile(
//         title: Text(allIdsList[index].toString()),
//        );
//       },
//       itemCount: allIdsList.length
//       ,);
//       },
//     ),
//     );
//     }else{
//       return Scaffold(
// body: Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,

//     children: [
//       ElevatedButton(onPressed: ()async{

//         final selectedIds= await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  VideoSelectionPage(),));
//         print('$selectedIds idss added');
//         widget.playList.id.value.addAll(selectedIds);
//         widget.playList.id.notifyListeners();
//         setState(() {
//           widget.videoId.addAll(selectedIds);
//           setState(() {

//           });

//         });

//       }, child: const Text('Add Videos')),
//       const Text('NO videos Found')
//     ],
//   ),
// ),
//       );
//     }

//   }
// }
