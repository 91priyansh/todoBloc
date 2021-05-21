import 'package:bloc_example/ui/styles/theme/appTheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {
  final AppTheme appTheme;
  ThemeState(this.appTheme);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(AppTheme.Light));

  void changeTheme(AppTheme appTheme) {
    emit(ThemeState(appTheme));
  }
}
