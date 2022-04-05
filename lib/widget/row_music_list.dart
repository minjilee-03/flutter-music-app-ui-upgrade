import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:make_music_app_2/screen/detail_music_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:id3/id3.dart';

class RowMusicList extends StatefulWidget {
  const RowMusicList({Key? key}) : super(key: key);

  @override
  State<RowMusicList> createState() => _RowMusicListState();
}

class _RowMusicListState extends State<RowMusicList> {
  String title = '';
  String image = '';

  @override
  void initState() {
    _music();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox.fromSize(
                            size: const Size.fromRadius(48),
                            child: getImage(image)),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailMusicScreen(
                                          title: title,
                                        )),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.black.withOpacity(0.05)),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 59, 50, 50),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, dynamic> metaData = {'': ''};

  Widget getImage(String metaimage) {
    var imagenJson = metaimage;
    const Base64Codec base64 = Base64Codec();
    if (imagenJson == null) return Container();
    var bytes = base64.decode(imagenJson);
    return Image.memory(bytes, fit: BoxFit.cover);
  }

  void _music() async {
    final musicFile = await rootBundle.load('assets/music/[도영] 마음을 드려요.mp3');

    final buffer = musicFile.buffer;

    final musicInstance = MP3Instance(musicFile.buffer.asUint8List());

    metaData = musicInstance.getMetaTags()!;

    if (musicInstance.parseTagsSync()) {
      print(metaData['Title']);
    }

    var metaTitle = metaData['Title'].toString();
    var metaimage = metaData['APIC']['base64'].toString();

    setState(() {
      title = metaTitle;
      image = metaimage;
    });
  }
}
