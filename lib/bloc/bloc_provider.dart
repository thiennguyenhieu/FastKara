import 'package:flutter/material.dart';

import 'package:fast_kara/bloc/app_manager_bloc.dart';

class BlocProvider extends InheritedWidget {
  final AppManagerBloc bloc;

  BlocProvider({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppManagerBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<BlocProvider>()).bloc;
}
