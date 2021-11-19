import 'package:flutter/material.dart';
import 'package:movie_app/search.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("BOOK OF MOVIES"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'IM Fell English SC',
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
      body: Search(),
    );
  }
}