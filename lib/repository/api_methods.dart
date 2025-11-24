import 'dart:convert';
import 'dart:io';

import 'package:api_methods/core/constants/api_methods.dart';
import 'package:http/http.dart' as http;

class ApiMethods {
  static Future<void> formDataApi({
    required String url,
    required File file,
  }) async {
    var response = await ApiHttp.multipartApi(url: url, image: file);
    if (response == null) {
      print("Multipart receiving null");
    } else {
      print("Image Uploaded");
    }
  }

  static Future<http.Response?> getUserData() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
      );
      if (response.statusCode == 200) {
        print("Status 200");
        return response;
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<http.Response?> getUser() async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://api.pixy.club/api/v1/me"),
          headers: {
            "Authorization":"Bearer oat_MTk4.MFJHcHlqX29zdE9iU2hSREp0RFhPQzMyeWJhdjJoMVMtdjByY2ZIXzE2MzgzMTUzNg"
          }
      );
      if (response.statusCode == 200) {
        print(response.body);
        return response;
      }else{

      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
