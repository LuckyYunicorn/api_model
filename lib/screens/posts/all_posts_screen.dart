import 'package:api_methods/bloc/posts/posts_bloc.dart';
import 'package:api_methods/bloc/posts/posts_event.dart';
import 'package:api_methods/screens/posts/post_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/posts/posts_state.dart';

class AllPostsScreen extends StatelessWidget {
  static const String routeName = "/all=posts";

  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(GetAllPosts()),
      child: Scaffold(
        appBar: AppBar(title: Text("All Post")),
        body: SafeArea(
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsFetchedState) {
                var data = state.postsModel.posts;
                return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print("88888888888888888888888888888888888888 ${data?[index]}");
                        //TODO
                        Navigator.pushNamed(
                          context,
                          PostDataScreen.routeName,
                          arguments: {
                            "id": data?[index].id,
                            "title": data?[index].title,
                          },
                        );
                      },
                      leading: Text("${data?[index].id}"),
                      title: Text("${data?[index].title}"),
                    );
                  },
                );
              }
              if (state is PostsLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: Text("No data"));
            },
          ),
        ),
      ),
    );
  }
}
