import 'package:api_methods/screens/multipart/multipart.dart';
import 'package:api_methods/screens/posts/all_posts_screen.dart';
import 'package:api_methods/screens/posts/post_data_screen.dart';
import 'package:api_methods/screens/posts/post_screen.dart';
import 'package:api_methods/screens/product/product_screen.dart';
import 'package:api_methods/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    //Initial Route
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => SplashScreen());

    //Product
    case ProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ProductScreen());

    //Add new post
    case PostScreen.routeName:
      return MaterialPageRoute(builder: (_) => const PostScreen());

    //ALl post
    case AllPostsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AllPostsScreen());

    // post data
    case PostDataScreen.routeName:
      final data = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (_) => PostDataScreen(data: data));

    // Multipart data
    case MultipartScreen.routeName:
      return MaterialPageRoute(builder: (_) => MultipartScreen());

    //default route
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text("No route defined for ${settings.name}")),
        ),
      );
  }
}
