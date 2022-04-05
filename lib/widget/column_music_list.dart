import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:make_music_app_2/screen/detail_music_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:id3/id3.dart';

class MusicListSlider extends StatelessWidget {
  const MusicListSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return const SizedBox(
          child: ColumnMusicList(),
        );
      },
    );
  }
}

class ColumnMusicList extends StatefulWidget {
  const ColumnMusicList({Key? key}) : super(key: key);

  @override
  State<ColumnMusicList> createState() => _ColumnMusicListState();
}

class _ColumnMusicListState extends State<ColumnMusicList> {
  String title = 'title';
  String album = 'album';
  String image = '';

  @override
  void initState() {
    _music();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 350,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        margin: const EdgeInsets.only(right: 5),
        child: ListView.builder(
          itemCount: 5,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 80,
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
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent.withOpacity(0.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 65,
                          height: 65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48),
                              child: getImage(image),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 59, 50, 50),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.1),
                              ),
                              Text(
                                album,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(180, 59, 50, 50),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.1),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                          child: Icon(
                            Icons.more_vert,
                            color: Color.fromARGB(180, 59, 50, 50),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Map<String, dynamic> metaData = {'': ''};
  Map<String, dynamic> metaData2 = {'': ''};

  Widget getImage(String metaimage) {
    var imagenJson = metaimage;
    const Base64Codec base64 = Base64Codec();
    if (imagenJson == null) return new Container();
    var bytes = base64.decode(imagenJson);
    return Image.memory(bytes, fit: BoxFit.cover);
  }

  void _music() async {
    final musicFile =
        await rootBundle.load('assets/music/JAEHYUN - I Like Me Better.mp3');

    final buffer = musicFile.buffer;

    final musicInstance = MP3Instance(musicFile.buffer.asUint8List());

    metaData = musicInstance.getMetaTags()!;

    if (musicInstance.parseTagsSync()) {
      print(metaData['Title']);
      print(metaData['Artist']);
    }

    var metaTitle = metaData['Title'].toString();
    var metaAlbum = metaData['Artist'].toString();
    var metaimage = metaData['APIC']['base64'].toString();

    setState(() {
      title = metaTitle;
      album = metaAlbum;
      image = metaimage;
    });
  }
}
