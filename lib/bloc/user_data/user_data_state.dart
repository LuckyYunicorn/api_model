import 'package:api_methods/models/user_data_model.dart';
import 'package:equatable/equatable.dart';

class UserDataState extends Equatable {
  final bool isLoading;
  final List<UserDataModel> userDataList;
  final List<UserDataModel> userDataTempList;
  final String message;

  const UserDataState({
    this.isLoading = false,
    this.userDataList = const <UserDataModel>[],
    this.userDataTempList = const <UserDataModel>[],
    this.message = "",
  });

  UserDataState copyWith({
    bool? isLoading,
    List<UserDataModel>? userDataList,
    List<UserDataModel>? userDataTempList,
    String? message,
  }) {
    return UserDataState(
      isLoading: isLoading ?? this.isLoading,
      userDataList: userDataList ?? this.userDataList,
      userDataTempList:userDataTempList ?? this.userDataTempList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [isLoading, userDataList, message,userDataTempList];
}
