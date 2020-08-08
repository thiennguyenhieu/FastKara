import 'package:flutter/material.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_util.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_widget.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_controller.dart';

class CustomLyric extends StatefulWidget {
  final String lyrics;
  const CustomLyric(this.lyrics);

  @override
  _CustomLyric createState() => _CustomLyric();
}

class _CustomLyric extends State<CustomLyric> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var controller = LyricController(vsync: this);
    var lyrics = LyricUtil.formatLyric(widget.lyrics);
    return LyricWidget(
      size: Size(
        double.infinity,
        double.infinity,
      ),
      lyrics: lyrics,
      controller: controller,
    );
  }
}
