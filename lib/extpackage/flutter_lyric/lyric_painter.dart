import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lyric.dart';

class LyricPainter extends CustomPainter with ChangeNotifier {
  List<Lyric> lyrics;

  List<Lyric> subLyrics;

  Size canvasSize = Size.zero;

  double lyricMaxWidth;

  double lyricGapValue;

  double subLyricGapValue;

  double _offset = 0;

  set offset(value) {
    _offset = value;
    notifyListeners();
  }

  get offset => _offset;

  int _currentLyricIndex = 0;

  get currentLyricIndex => _currentLyricIndex;

  set currentLyricIndex(value) {
    _currentLyricIndex = value;
    notifyListeners();
  }

  TextStyle lyricTextStyle;

  TextStyle draggingLyricTextStyle;

  TextStyle draggingSubLyricTextStyle;

  TextStyle subLyricTextStyle;

  TextStyle currLyricTextStyle;

  TextStyle currSubLyricTextStyle;

  int _draggingLine;

  get draggingLine => _draggingLine;

  set draggingLine(value) {
    this._draggingLine = value;
    notifyListeners();
  }

  final List<TextPainter> lyricTextPaints;

  final List<TextPainter> subLyricTextPaints;

  LyricPainter(this.lyrics, this.lyricTextPaints, this.subLyricTextPaints,
      {this.subLyrics,
      TickerProvider vsync,
      this.lyricTextStyle,
      this.subLyricTextStyle,
      this.currLyricTextStyle,
      this.currSubLyricTextStyle,
      this.draggingLyricTextStyle,
      this.draggingSubLyricTextStyle,
      this.lyricGapValue,
      this.subLyricGapValue,
      this.lyricMaxWidth});

  @override
  void paint(Canvas canvas, Size size) {
    canvasSize = size;
    lyricTextPaints[currentLyricIndex]
      ..text = TextSpan(
          text: lyrics[currentLyricIndex].lyric, style: currLyricTextStyle)
      ..layout(maxWidth: lyricMaxWidth);
    var currentLyricY = _offset +
        size.height / 2 -
        lyricTextPaints[currentLyricIndex].height / 2;

    for (int lyricIndex = 0; lyricIndex < lyrics.length; lyricIndex++) {
      var currentLyric = lyrics[lyricIndex];
      var isCurrLine = currentLyricIndex == lyricIndex;
      var isDraggingLine = _draggingLine == lyricIndex;
      var currentLyricTextPaint = lyricTextPaints[lyricIndex]
        ..text = TextSpan(
            text: currentLyric.lyric,
            style: isCurrLine
                ? currLyricTextStyle
                : isDraggingLine ? draggingLyricTextStyle : lyricTextStyle);
      currentLyricTextPaint.layout(maxWidth: lyricMaxWidth);
      var currentLyricHeight = currentLyricTextPaint.height;
      if (currentLyricY < size.height && currentLyricY > 0) {
        currentLyricTextPaint
          ..paint(
              canvas,
              Offset((size.width - currentLyricTextPaint.width) / 2,
                  currentLyricY));
      }

      currentLyricY += currentLyricHeight + lyricGapValue;

      if (subLyrics != null) {
        List<Lyric> remarkLyrics = subLyrics
            .where((subLyric) =>
                subLyric.startTime >= currentLyric.startTime &&
                subLyric.endTime <= currentLyric.endTime)
            .toList();
        remarkLyrics.forEach((remarkLyric) {
          var subIndex = subLyrics.indexOf(remarkLyric);

          var currentSubPaint = subLyricTextPaints[subIndex]
            ..text = TextSpan(
                text: remarkLyric.lyric,
                style: isCurrLine
                    ? currSubLyricTextStyle
                    : isDraggingLine
                        ? draggingSubLyricTextStyle
                        : subLyricTextStyle);

          if (currentLyricY < size.height && currentLyricY > 0) {
            currentSubPaint
              ..layout(maxWidth: lyricMaxWidth)
              ..paint(
                  canvas,
                  Offset((size.width - subLyricTextPaints[subIndex].width) / 2,
                      currentLyricY));
          }
          currentSubPaint..layout(maxWidth: lyricMaxWidth);
          currentLyricY += currentSubPaint.height + subLyricGapValue;
        });
      }
    }
  }

  @override
  bool shouldRepaint(LyricPainter oldDelegate) {
    return oldDelegate.currentLyricIndex != currentLyricIndex;
  }
}
