import 'dart:convert';

import 'package:api_methods/bloc/user_data/user_data_event.dart';
import 'package:api_methods/bloc/user_data/user_data_state.dart';
import 'package:api_methods/models/user_data_model.dart';
import 'package:api_methods/repository/api_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataState()) {
    on<GetUserData>(_getUserData);
    on<SearchUser>(_searchUser);
  }
  Future<void> _getUserData(
    GetUserData event,
    Emitter<UserDataState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    http.Response? response = await ApiMethods.getUserData();
    if (response == null) {
      print("Response is null");
      emit(state.copyWith(isLoading: false, message: "Response is null"));
      return;
    }
    var res = jsonDecode(response.body);
    List<dynamic> decodedList = res;
    List<UserDataModel> user = decodedList
        .map((e) => UserDataModel.fromJson(e))
        .toList();
    emit(
      state.copyWith(
        isLoading: false,
        userDataList: user,
        message: "Data fetched successfully",
      ),
    );
  }

  void _searchUser(SearchUser event, Emitter<UserDataState> emit) {
    try {
      if (event.query != null) {
        List<UserDataModel> filteredList = state.userDataList
            .where((element) => element.name == event.query)
            .toList();
        emit(state.copyWith(userDataTempList: filteredList));
      }
    } catch (e) {
      print(e);
    }
  }
}
