import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../repository/api_methods.dart';
import 'user_event.dart';
import 'user_state.dart';
import 'package:http/http.dart' as http;

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>(_loadUser);
  }

  Future<void> _loadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());

      http.Response? response = await ApiMethods.getUser();

      if (response == null) {
        emit(UserError("User data not found"));
      } else {
        print(response.body);
        var res = jsonDecode(response.body);
        MeModel meModel = MeModel.fromJson(res);
        emit(UserLoaded(meModel));
      }
    } catch (e) {
      print(e);
      emit(UserError(e.toString()));
    }
  }
}
