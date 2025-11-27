import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Onboard2Widget extends StatelessWidget {
  const Onboard2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/onboard2.png", fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
