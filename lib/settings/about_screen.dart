import 'package:flutter/material.dart';
import 'package:nova_videoplayer/functions/global_variables.dart';

import '../functions/text_class.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        backgroundColor: colorBlack,
        title: Text(TextAllWidget.settingAboutNova),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Welcome to Nova Video player App, make your life more live.We are dedicated to providing you the very best quality of sound and the music varient,with an emphasis on new features. playlists and favourites,and a rich user experience\n\n Founded in 2022 by Noufal Vp . Simfonie app is our first major project with a basic performance of music hub and creates a better versions in future.Simfonie gives you the best music experience that you never had. it includes attractivemode of UI\'s and good practices.\n\nIt gives good quality and had increased the settings to power up the system as well as to provide better music rythms.\n\nWe hope you enjoy our music as much as we enjoy offering them to you.If you have any questions or comments, please don\'t hesitate to contact us.\n\nSincerely,\n\nNoufal Vp',
          style: TextStyle(
              fontFamily: 'poppins', fontSize: 13, color: Colors.white),
        ),
      ),
    );
  }
}
