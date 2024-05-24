import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music/song_model.dart';

class empty extends StatelessWidget {
  
  const empty({super.key});
 
  @override
  Widget build(BuildContext context) {
    var i = Random().nextInt(Song.songs.length - 1);
    var oo = Song.songs[i];
    Get.toNamed('/song', arguments: oo);
    return const Placeholder();
  }
}