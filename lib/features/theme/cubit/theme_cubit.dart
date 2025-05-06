import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // false = Light Theme, true = Dark Theme

  void toggleTheme() => emit(!state); // Toggle between light and dark themes
}
