import 'dart:convert';

import 'package:http/http.dart' as http;

import '../static/const_http_path.dart';
import '../model/song_model.dart';

class RestAPI {
  static final List<SongModel> _songBook = [];

  static Future<List<SongModel>> fetchSongBook() async {
    _songBook.clear();

    var response = await http.get(HttpPath.pathSongBook);

    if (response.statusCode == 200) {
      var songsJsonData = json.decode(response.body);

      for (var songsInfo in songsJsonData) {
        SongModel song = SongModel(songsInfo["songid"], songsInfo["title"],
            songsInfo["singer"], songsInfo["imgurl"], songsInfo["beaturl"]);
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
