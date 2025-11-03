import 'dart:convert';

import 'package:api_methods/bloc/posts/posts_event.dart';
import 'package:api_methods/bloc/posts/posts_state.dart';
import 'package:api_methods/models/posts_model.dart';
import 'package:api_methods/repository/posts/posts_repository.dart';
import 'package:api_methods/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class PostsBloc extends Bloc<PostEvent, PostsState> {
  PostsRepository postsRepository = PostsRepository();
  PostsBloc() : super(PostsInitialState()) {
    on<AddPosts>(_addPost);
    on<GetAllPosts>(_getAllPosts);
    on<UpdatePosts>(_updatePosts);
  }
  Future<void> _addPost(AddPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());

    http.Response response = await postsRepository.addPosts(
      postReqModel: event.postsReqModel,
    );

    if (response.statusCode == 201) {
      emit(
        PostsLoadedState(message: "success", postsStatus: PostsStatus.success),
      );
    } else {
      var res = jsonDecode(response.body);
      emit(
        PostsErrorState(
          message: res['message'],
          postsStatus: PostsStatus.error,
        ),
      );
    }
  }

  Future<void> _getAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    http.Response response = await postsRepository.fetchPosts();
    var postsModel = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final postsModel = PostsModel.fromJson(jsonDecode(response.body));
      emit(PostsFetchedState(postsModel: postsModel));
    } else {
      emit(
        PostsErrorState(
          message: postsModel['message'],
          postsStatus: PostsStatus.error,
        ),
      );
    }
  }

  Future<void> _updatePosts(UpdatePosts event, Emitter<PostsState> emit)async{
    emit(PostsLoadingState());
    http.Response response = await postsRepository.updatePosts(id:event.id,title: event.title);
    var postsModel = jsonDecode(response.body);

    if(response.statusCode == 200){
      emit(PostsUpdated(message: "Data updates"));
    }else{
      emit(PostsErrorState(message: postsModel['message'], postsStatus: PostsStatus.error));
    }
  }
}
