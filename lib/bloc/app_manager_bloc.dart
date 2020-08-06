import 'package:fast_kara/bloc/song_book_bloc.dart';
import 'package:fast_kara/bloc/play_song_bloc.dart';

class AppManagerBloc {
  SongBookBloc _songBookBloc;
  PlaySongBloc _playSongBloc;

  AppManagerBloc() {
    _songBookBloc = SongBookBloc();
    _playSongBloc = PlaySongBloc();
  }

  SongBookBloc get songBookBloc => _songBookBloc;
  PlaySongBloc get playSongBloc => _playSongBloc;
}
