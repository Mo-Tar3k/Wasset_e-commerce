import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class CustomBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('${bloc.runtimeType} $transition');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      developer.log('${bloc.runtimeType} $change');
    }
  }
}
