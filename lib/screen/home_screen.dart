import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:make_music_app_2/widget/fast_choice.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: const Color.fromARGB(255, 59, 50, 50),
          icon: const Icon(Icons.search_outlined),
          iconSize: 30,
          onPressed: () => {},
        ),
        actions: [
          IconButton(
            color: const Color.fromARGB(255, 59, 50, 50),
            icon: const Icon(Icons.more_vert_outlined),
            iconSize: 30,
            onPressed: () => {},
          ),
        ],
      ),
      body: SizedBox(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const <Widget>[FastChoice()],
        ),
      ),
    );
  }
}
