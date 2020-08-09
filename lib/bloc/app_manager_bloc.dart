import 'package:fast_kara/bloc/song_book_bloc.dart';
import 'package:fast_kara/bloc/sign_in_bloc.dart';

class AppManagerBloc {
  SongBookBloc _songBookBloc;
  SignInBloc _signInBloc;

  AppManagerBloc() {
    _songBookBloc = SongBookBloc();
    _signInBloc = SignInBloc();
  }

  SongBookBloc get songBookBloc => _songBookBloc;
  SignInBloc get signInBloc => _signInBloc;
}
