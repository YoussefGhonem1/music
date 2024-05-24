import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music/playlist_model.dart';
import 'package:music/playlist_screen.dart';
import 'package:music/song_screen.dart';
import 'home_screen.dart';
import 'package:music/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/', page: ()=> const HomeScreen()),
        GetPage(name: '/song', page: ()=> const SongScreen()),
        GetPage(name: '/playlist', page: ()=> const PlaylistScreen()),

      ],
      //title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

