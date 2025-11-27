import 'package:api_methods/bloc/theme/theme_bloc.dart';

import 'package:api_methods/bloc/theme/theme_event.dart';

import 'package:api_methods/bloc/user_data/user_data_bloc.dart';

import 'package:api_methods/bloc/user_data/user_data_event.dart';

import 'package:api_methods/bloc/user_data/user_data_state.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataScreen extends StatefulWidget {

  const UserDataScreen({super.key});

  @override

  State<UserDataScreen> createState() => _UserDataScreenState();

}

class _UserDataScreenState extends State<UserDataScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // 🔹 Slide Animation (staggered from right)
  Animation<Offset> buildSlide(int index) {
    double start = (index * 0.1).clamp(0.0, 0.8); // prevent >1.0
    double end = (start + 0.5).clamp(0.0, 1.0);   // each item animates for 0.5

    return Tween<Offset>(
      begin: const Offset(1.0, 0), // slide from right
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().state.isDarkMode;

    return BlocProvider(
      create: (context) => UserDataBloc()..add(GetUserData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Data"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ChangeTheme());
              },
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            animationController.reset();
            animationController.forward();
            context.read<UserDataBloc>().add(GetUserData());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: BlocBuilder<UserDataBloc, UserDataState>(
                    builder: (context, state) {
                      return SearchBar(
                        onChanged: (query) {
                          context.read<UserDataBloc>()..add(SearchUser(query: query));
                          animationController.reset();
                          animationController.forward();
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                          child: SizedBox(
                              height: 80, child: CircularProgressIndicator()));
                    }

                    final list = state.userDataTempList.isEmpty
                        ? state.userDataList
                        : state.userDataTempList;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final data = list[index];
                        final slide = buildSlide(index);

                        // ✅ SlideTransition instead of manual Transform
                        return SlideTransition(
                          position: slide,
                          child: _userTile(
                            firstName: data.name,
                            lastName: data.username,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
    title: Text(firstName ?? ""),
    subtitle: Text(lastName ?? ""),
    trailing: const Icon(Icons.arrow_forward_ios),
  );
}
