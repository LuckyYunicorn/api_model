import 'package:api_methods/models/post_req_model.dart';
import 'package:equatable/equatable.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPosts extends PostEvent {
  final PostsReqModel postsReqModel;

  const AddPosts({required this.postsReqModel});

  @override
  List<Object?> get props => [postsReqModel];
}

class GetAllPosts extends PostEvent {}

class UpdatePosts extends PostEvent {
  final String id;
  final String title;
  const UpdatePosts({required this.id,required this.title,});
  @override
  // TODO: implement props
  List<Object?> get props => [id,title];
}
