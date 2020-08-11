import 'dart:io';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fast_kara/static/const_http_path.dart';
import 'package:fast_kara/model/song_model.dart';

class SongBookBloc {
  List<SongModel> _songBook = [];
  BehaviorSubject<List<SongModel>> _subjectSongBook;
  ValueStream<List<SongModel>> get updateSongBook => _subjectSongBook.stream;

  SongBookBloc() {
    _subjectSongBook = new BehaviorSubject<List<SongModel>>();
  }

  _fetchSongBook() async {
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

        SongModel song = SongModel(songsInfo["songid"], songsInfo["title"],
            songsInfo["singer"], urlImage, urlBeat, urlLyrics);
        _songBook.add(song);
      }

      _subjectSongBook.sink.add(_songBook);
    }
  }

  fetchSongBook() {
    _fetchSongBook();
  }

  void dispose() {
    _subjectSongBook.close();
  }
}
