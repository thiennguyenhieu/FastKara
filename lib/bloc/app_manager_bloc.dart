import 'package:fast_kara/bloc/play_song_bloc.dart';
import 'package:fast_kara/bloc/song_book_bloc.dart';
import 'package:fast_kara/bloc/sign_in_bloc.dart';

class AppManagerBloc {
  SongBookBloc _songBookBloc;
  SignInBloc _signInBloc;
  PlaySongBloc _playSongBloc;

  AppManagerBloc() {
    _songBookBloc = SongBookBloc();
    _signInBloc = SignInBloc();
    _playSongBloc = PlaySongBloc();
  }

  SongBookBloc get songBookBloc => _songBookBloc;
  SignInBloc get signInBloc => _signInBloc;
  PlaySongBloc get playSongBloc => _playSongBloc;
}
