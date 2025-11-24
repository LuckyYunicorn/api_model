import 'package:api_methods/bloc/theme/theme_event.dart';
import 'package:api_methods/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc():super(ThemeState()){
    on<ChangeTheme>(_changeTheme);
  }
  void _changeTheme(ChangeTheme event, Emitter<ThemeState>emit){
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }
}