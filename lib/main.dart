import 'package:api_methods/bloc/product/product_bloc.dart';
import 'package:api_methods/routes/routes.dart';
import 'package:api_methods/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Api());
}

class Api extends StatelessWidget {
  const Api({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Api",
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}
