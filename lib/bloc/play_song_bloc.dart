import 'dart:async';

class PlaySongBloc {
  int counter = 0;

  StreamController<int> _counterController =
      new StreamController<int>.broadcast();

  Function(int) get addCounter => _counterController.sink.add;

  Stream<int> get counterValue => _counterController.stream;

  increment() {
    addCounter(++counter);
  }

  dispose() {
    _counterController?.close();
  }
}
