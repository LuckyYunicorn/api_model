import 'package:api_methods/bloc/posts/posts_bloc.dart';
import 'package:api_methods/bloc/posts/posts_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/posts/posts_state.dart';

class PostDataScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  static const String routeName = "/post-data";

  const PostDataScreen({super.key, required this.data});

  @override
  State<PostDataScreen> createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  late TextEditingController _titleController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.data['title']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is PostsUpdated){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message,)));
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text(widget.data['id'].toString())),
          body: Column(
            children: [
              TextField(controller: _titleController),
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<PostsBloc>().add(
                        UpdatePosts(
                          id: widget.data['id'].toString(),
                          title: _titleController.text,
                        ),
                      );
                    },
                    child: (state is PostsLoadingState)
                        ? CircularProgressIndicator()
                        : Text("Update"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
