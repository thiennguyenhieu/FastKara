import 'package:fast_kara/model/song_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class SearchManagerBloc {
  FocusNode _searchFocusNode = FocusNode();
  List<SongModel> _songBookSearching = [];

  BehaviorSubject<FocusNode> _subjectFocusNode;
  ValueStream<FocusNode> get getFocusNodeUpdate => _subjectFocusNode.stream;

  BehaviorSubject<List<SongModel>> _subjectSongBookInSearch;
  ValueStream<List<SongModel>> get getSongBookInSearch =>
      _subjectSongBookInSearch.stream;

  SearchManagerBloc() {
    _subjectFocusNode = new BehaviorSubject<FocusNode>();
    _subjectSongBookInSearch = new BehaviorSubject<List<SongModel>>();
  }

  void requestFocus() {
    _searchFocusNode.requestFocus();
    _subjectFocusNode.sink.add(_searchFocusNode);
  }

  FocusNode getFocusNode() {
    return _searchFocusNode;
  }

  _searchProcess(List<SongModel> originalSongBook, String searchTextInProgress) {
    _songBookSearching.clear();
    for (int i = 0; i < originalSongBook.length; i++) {
      if (originalSongBook[i].title.contains(searchTextInProgress)) {
        _songBookSearching.add(originalSongBook[i]);
      }
    }

    _subjectSongBookInSearch.sink.add(_songBookSearching);
  }

  void searchProcess(
      List<SongModel> originalSongBook, String searchTextInProgress) {
    _searchProcess(originalSongBook, searchTextInProgress);
  }

  void dispose() {
    _subjectFocusNode.close();
    _subjectSongBookInSearch.close();
  }
}
