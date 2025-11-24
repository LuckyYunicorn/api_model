import 'dart:io';

import 'package:api_methods/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class MultipartScreen extends StatelessWidget {
  static const String routeName = "/multipart";
  const MultipartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text("Upload an image")),
        body: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  context.read<ImagePickerBloc>().add(PickImageFromGallery());
                },
                child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                  builder: (context, state) {
                    if (state.file != null) {
                      return CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(state.file!.path)),
                      );
                    } else {
                      return CircleAvatar(radius: 80);
                    }
                  },
                ),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Upload Image")),
          ],
        ),
      ),
    );
  }
}
