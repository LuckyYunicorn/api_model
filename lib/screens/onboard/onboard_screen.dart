import 'package:api_methods/screens/onboard/widgets/onboard_1_widget.dart';
import 'package:api_methods/screens/onboard/widgets/onboard_2_widget.dart';
import 'package:api_methods/screens/onboard/widgets/onboard_3_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // print("$height  --  $width");
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [Onboard1Widget(), Onboard2Widget(), Onboard3Widget()],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: JumpingDotEffect(),
                  onDotClicked: (index) {
                    _controller.jumpToPage(index);
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
