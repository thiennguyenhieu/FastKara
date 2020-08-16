import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class SearchManagerBloc {
  FocusNode _searchFocusNode = FocusNode();

  BehaviorSubject<FocusNode> _subjectFocusNode;
  ValueStream<FocusNode> get updateSongBook => _subjectFocusNode.stream;

  SearchManagerBloc() {
    _subjectFocusNode = new BehaviorSubject<FocusNode>();
  }

  void requestFocus() {
    _searchFocusNode.requestFocus();
    _subjectFocusNode.sink.add(_searchFocusNode);
  }

  FocusNode getFocusNode() {
    return _searchFocusNode;
  }

  void dispose() {
    _subjectFocusNode.close();
  }
}
