import 'package:flutter/material.dart';
import 'package:make_music_app_2/widget/column_music_list.dart';
import 'package:make_music_app_2/widget/row_music_list.dart';

class FastChoice extends StatelessWidget {
  const FastChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 10, 20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          subTitle('이 노래로 뮤직 스테이션 시작하기'),
          title('빠른 선곡'),
          const SizedBox(
            height: 400,
            child: MusicListSlider(),
          ),
          title('즐겨 듣는 음악'),
          const SizedBox(
            height: 400,
            child: RowMusicList(),
          ),
        ],
      ),
    );
  }
}

Widget title(String text) => Text(
      text,
      style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w800),
    );

Widget subTitle(String text) => Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
