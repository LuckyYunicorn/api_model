import 'package:api_methods/models/posts_model.dart';
import 'package:api_methods/utils/enums.dart';
import 'package:equatable/equatable.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final String message;
  final PostsStatus postsStatus;
  const PostsLoadedState({required this.message, required this.postsStatus});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class PostsFetchedState extends PostsState {
  final PostsModel postsModel;
  const PostsFetchedState({required this.postsModel});
  @override
  // TODO: implement props
  List<Object?> get props => [postsModel];
}

class PostsUpdated extends PostsState {
  final String message;
  const PostsUpdated({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class PostsErrorState extends PostsState {
  final String message;
  final PostsStatus postsStatus;
  const PostsErrorState({required this.message, required this.postsStatus});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
