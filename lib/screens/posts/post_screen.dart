import 'package:api_methods/bloc/posts/posts_bloc.dart';
import 'package:api_methods/bloc/posts/posts_event.dart';
import 'package:api_methods/bloc/posts/posts_state.dart';
import 'package:api_methods/models/post_req_model.dart';
import 'package:api_methods/screens/posts/all_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  static const String routeName = "/post";

  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostsLoadedState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is PostsErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Builder(
          builder: (context) {
            // This context is **under BlocProvider**
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("Add new post"),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    _textFormField(
                      labelText: "UserId",
                      hintText: "Enter UserID",
                      controller: _userIdController,
                    ),
                    _textFormField(
                      labelText: "Title",
                      hintText: "Enter Title",
                      controller: _titleController,
                    ),
                    BlocBuilder<PostsBloc, PostsState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            print("Hello ${_userIdController.text}");
                            context.read<PostsBloc>().add(
                              AddPosts(
                                postsReqModel: PostsReqModel(
                                  userId: _userIdController.text,
                                  title: _titleController.text,
                                ),
                              ),
                            );
                          },
                          child: (state is PostsLoadingState)
                              ? Center(child: CircularProgressIndicator())
                              : Text("Submit"),
                        );
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AllPostsScreen.routeName);
                },
                child: Icon(Icons.arrow_forward),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _textFormField({
  required String labelText,
  required String hintText,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 18),
      ),
    ),
  );
}
