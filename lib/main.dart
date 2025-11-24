import 'package:api_methods/bloc/product/product_bloc.dart';
import 'package:api_methods/bloc/theme/theme_bloc.dart';
import 'package:api_methods/bloc/theme/theme_state.dart';
import 'package:api_methods/bloc/user/user_bloc.dart';
import 'package:api_methods/bloc/user/user_event.dart';
import 'package:api_methods/core/theme/app_theme.dart';
import 'package:api_methods/routes/routes.dart';
import 'package:api_methods/screens/image/image_file_download.dart';
import 'package:api_methods/screens/product/product_screen.dart';
import 'package:api_methods/screens/user_data/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => UserBloc()..add(LoadUserEvent())),
      ],
      child: const Api(),
    ),
  );
}

class Api extends StatelessWidget {
  const Api({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final isDark = themeState.isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.lightTheme : AppTheme.darkTheme,
      title: "Api",
      // onGenerateRoute: (settings) => onGenerateRoute(settings),
      home: UserDataScreen(),
    );
  }
}
