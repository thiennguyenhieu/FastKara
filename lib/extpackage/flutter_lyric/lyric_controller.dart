import 'dart:async';

import 'package:flutter/cupertino.dart';

class LyricController extends ChangeNotifier {
  Duration _progress = Duration();

  set progress(Duration value) {
    _progress = value;
    notifyListeners();
  }

  Duration get progress => _progress;

  Timer draggingTimer;

  Duration draggingTimerDuration;

  bool _isDragging = false;

  get isDragging => _isDragging;

  set isDragging(value) {
    _isDragging = value;
    notifyListeners();
  }

  Duration draggingProgress;

  Function draggingComplete;

  double draggingOffset;

  TickerProvider vsync;

  AnimationController animationController;

  double previousRowOffset = 0;

  int oldLine = 0;
  int draggingLine = 0;

  LyricController({this.vsync, this.draggingTimerDuration});
}
