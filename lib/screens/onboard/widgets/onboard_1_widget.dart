import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Onboard1Widget extends StatelessWidget {
  const Onboard1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        // clipBehavior: Clip.hardEdge,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                child: Image.asset("assets/onboard1.png", fit: BoxFit.fill),
              ),
              // space for text
            ],
          ),

          // Positioned text
          Positioned(
            top: MediaQuery.of(context).size.height * 0.56,
            left: 10,
            right: 20,
            child: const AutoSizeText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor.",
              minFontSize: 14,
              maxFontSize: 30,
              style: TextStyle(fontSize: 30),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
