import 'package:api_methods/bloc/product/product_bloc.dart';
import 'package:api_methods/bloc/theme/theme_bloc.dart';
import 'package:api_methods/bloc/user/user_bloc.dart';
import 'package:api_methods/bloc/user/user_event.dart';
import 'package:api_methods/core/theme/app_theme.dart';
import 'package:api_methods/routes/routes.dart';
import 'package:api_methods/screens/my_location/geolocator.dart';
import 'package:api_methods/screens/onboard/onboard_screen.dart';
import 'package:api_methods/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';
// Top-level function for handling background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => UserBloc()..add(LoadUserEvent())),
        // Add ProductBloc if needed:
        // BlocProvider(create: (context) => ProductBloc()),
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

    return ScreenUtilInit(
      designSize: const Size(412.95238095238096, 918.8571428571429),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Api",
            theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
            // onGenerateRoute: (settings) => onGenerateRoute(settings),
            home: OnboardScreen(),
          );
        }
      ),
    );
  }
}
