import 'package:equatable/equatable.dart';

abstract class UserDataEvent extends Equatable{
  const UserDataEvent();
  @override
  List<Object?> get props => [];
}

class GetUserData extends UserDataEvent{}

class SearchUser extends UserDataEvent{
  final String? query;
  const SearchUser({this.query});

  @override
  List<Object?> get props => [query];
}