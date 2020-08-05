import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fast_kara/static/const_http_path.dart';
import 'package:fast_kara/model/song_model.dart';

class RestAPI {
  static final List<SongModel> _songBook = [];
  static final refStorage = FirebaseStorage.instance.ref();

  static Future<List<SongModel>> fetchSongBook() async {
    _songBook.clear();

    var response = await http.get(HttpPath.pathSongBook);

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
      return _songBook;
    } else {
      return [];
    }
  }

  static List<SongModel> getSongBook() {
    return _songBook;
  }
}
