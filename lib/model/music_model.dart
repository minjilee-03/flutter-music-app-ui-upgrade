import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:id3/id3.dart';

class Music {
  late String title;
  late String artist;

  Music({
    required this.title,
    required this.artist,
  });

  void _music() async {
    final musicFile =
        await rootBundle.load('assets/music/joy-ride by aves Artlist.mp3');

    final buffer = musicFile.buffer;

    final musicInstance = MP3Instance(musicFile.buffer.asUint8List());

    final metaData = musicInstance.getMetaTags();

    title = metaData!['Title'].toString();
    artist = metaData['Artist'].toString();

    if (musicInstance.parseTagsSync()) {
      print(musicInstance.getMetaTags());
    }
    print('==>');
    print(metaData['Title'].toString() + metaData['Artist'].toString());
  }
}
