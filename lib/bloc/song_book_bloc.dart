import 'dart:io';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fast_kara/static/const_http_path.dart';
import 'package:fast_kara/model/song_model.dart';

class SongBookBloc {
  List<SongModel> _songBook = [];

  BehaviorSubject<List<SongModel>> _subjectSongBookByView;
  ValueStream<List<SongModel>> get getSongBookByView =>
      _subjectSongBookByView.stream;

  BehaviorSubject<List<SongModel>> _subjectSongBookBySearch;
  ValueStream<List<SongModel>> get getSongBookBySearch =>
      _subjectSongBookBySearch.stream;

  SongBookBloc() {
    _subjectSongBookByView = new BehaviorSubject<List<SongModel>>();
    _subjectSongBookBySearch = new BehaviorSubject<List<SongModel>>();
  }

  _fetchSongBook() async {
    _songBook.clear();
    var response = await http.get(HttpPath.pathSongBook);
    final refStorage = FirebaseStorage.instance.ref();

    if (response.statusCode == HttpStatus.ok) {
      var songsJsonData = json.decode(response.body);

      for (var songsInfo in songsJsonData) {
        String urlImage =
            (await refStorage.child(songsInfo["imgurl"]).getDownloadURL())
                .toString();
        String urlBeat =
            (await refStorage.child(songsInfo["beaturl"]).getDownloadURL())
                .toString();
        String urlLyrics =
            (await refStorage.child(songsInfo["lyrics"]).getDownloadURL())
                .toString();

        SongModel song = SongModel(
          songsInfo["songid"],
          songsInfo["title"],
          songsInfo["singer"],
          urlImage,
          urlBeat,
          urlLyrics,
          songsInfo["viewcount"],
          songsInfo["searchcount"],
        );
        _songBook.add(song);
      }

      _songBook.sort((a, b) => b.viewCount.compareTo(a.viewCount));
      _subjectSongBookByView.sink.add(_songBook);

      List<SongModel> _songBookSearch = [..._songBook];
      _songBookSearch.sort((a, b) => b.searchCount.compareTo(a.searchCount));
      _subjectSongBookBySearch.sink.add(_songBookSearch);
    }
  }

  fetchSongBook() {
    _fetchSongBook();
  }

  getSongBook() {
    return _songBook;
  }

  void dispose() {
    _subjectSongBookByView.close();
    _subjectSongBookBySearch.close();
  }
}
