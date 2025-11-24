import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageFileDownload extends StatefulWidget {
  const ImageFileDownload({super.key});

  @override
  State<ImageFileDownload> createState() => _ImageFileDownloadState();
}

class _ImageFileDownloadState extends State<ImageFileDownload> {
  double progress = 0.0;
  Future<String> getDownloadPath() async {
    if (Platform.isAndroid) {
      // Request storage permission

      Directory? dir = Directory("/storage/emulated/0/Download");
      return dir.path;
    } else {
      // iOS → no public Downloads folder
      Directory dir = await getApplicationDocumentsDirectory();
      return dir.path;
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
    final path = await getDownloadPath();
    final filePath = "$path/fileName.jpg";

    await Dio().download(
      "https://m.media-amazon.com/images/I/61qbMx4oXJL._AC_UF1000,1000_QL80_.jpg",
      filePath,
      onReceiveProgress: (received, total) {
        setState(() {
          if((progress = received / total) == 1.0){
            progress = 0.0;
          }
          if (total != 1) {
            progress = received / total;
            print(progress);
          }


        });

      },
    );

    print("Saved at: $filePath");
  }

  @override
  Widget build(BuildContext context) {

    const imageUrl =
        "https://m.media-amazon.com/images/I/71SiLxdQ0jL._AC_UF1000,1000_QL80_.jpg";

    return Scaffold(
      appBar: AppBar(title: Text("Image Download")),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(imageUrl),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              semanticsLabel: progress.toString(),
              value: progress,
              minHeight: 8,
            ),
          ),
          SizedBox(height: 20),
          Text("${(progress * 100).toStringAsFixed(0)}%"),
          ElevatedButton(
            onPressed: () {
              downloadFile(imageUrl, "my_image.jpg");
            },
            child: Text("Download"),
          ),
        ],
      ),
    );
  }
}
