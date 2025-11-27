import 'package:api_methods/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 20,
        children: [
          SizedBox(height: 30.h),
          Container(
            color: Colors.grey,
            height: 300.h,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis.",
              style: AppTextTheme.titleStyleLB30bb,
            ),
          ),
          Container(
            color: Colors.grey,
            height: 300,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis.",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
