import 'package:api_methods/bloc/theme/theme_bloc.dart';
import 'package:api_methods/bloc/theme/theme_event.dart';
import 'package:api_methods/bloc/user/user_bloc.dart';
import 'package:api_methods/bloc/user/user_bloc.dart';
import 'package:api_methods/bloc/user/user_event.dart';
import 'package:api_methods/bloc/user_data/user_data_bloc.dart';
import 'package:api_methods/bloc/user_data/user_data_event.dart';
import 'package:api_methods/bloc/user_data/user_data_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_state.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final isDark = themeState.isDarkMode;
    return BlocProvider(
      create: (context) => UserDataBloc()..add(GetUserData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Data"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ChangeTheme());
              },
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            ),
          ],
        ),
        body: RefreshIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBar(
                  onChanged: (value) {
                    context.read<UserDataBloc>().add(SearchUser(query: value));
                  },
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return (state is UserLoaded)
                        ? Text(
                            "${state.user.data?.user?.firstName} ${state.user.data?.user?.lastName}",
                          )
                        : AutoSizeText(
                      'This text will automatically resize to fit the available space.',
                      style: TextStyle(fontSize: 50), // Initial style
                      minFontSize: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.userDataList.length,
                      itemBuilder: (context, index) {
                        var data = state.userDataList[index];
                        return _userTile(
                          firstName: data.name,
                          lastName: data.username,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          onRefresh: () async {
            context.read<UserBloc>()..add(LoadUserEvent());
          },
        ),
      ),
    );
  }
}

Widget _userTile({String? firstName, String? lastName}) {
  return ListTile(
    leading: CircleAvatar(
      child: Text("${firstName?[0] ?? ""}${lastName?[0] ?? ""}"),
    ),
    title: Text("${firstName ?? ""}"),
    subtitle: Text("${lastName ?? ""}"),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
      print("object");
    },
  );
}
