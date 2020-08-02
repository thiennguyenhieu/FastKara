class SongModel {
  final int songId;
  final String title;
  final String singer;
  final String imgUrl;
  final String beatUrl;
  final String lyrics;

  SongModel(this.songId, this.title, this.singer, this.imgUrl, this.beatUrl,
      this.lyrics);
}

class SongSingleton {
  static final SongSingleton _songSingleton = SongSingleton._internal();
  static List<SongModel> songList;

  factory SongSingleton() {
    return _songSingleton;
  }

  SongSingleton._internal();

  static SongSingleton get instance => _songSingleton;

  addSongList(List<SongModel> song) {
    songList = song;
  }

  List<SongModel> getSongList(){
    return songList;
  }

}