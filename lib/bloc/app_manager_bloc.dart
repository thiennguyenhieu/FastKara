import 'package:fast_kara/bloc/play_song_bloc.dart';

class AppManagerBloc {
  PlaySongBloc _playSongBloc;

  AppManagerBloc() {
    _playSongBloc = PlaySongBloc();
  }

  PlaySongBloc get playSongBloc => _playSongBloc;
}
