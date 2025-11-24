import 'dart:io';

import 'package:http/http.dart' as http;

class ApiHttp {
  //Get Api
  static Future<http.Response?> getApi({required String url}) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //Multipart
  static Future<http.StreamedResponse?> multipartApi({
    required String url,
    required File? image,
    Map<String, dynamic>? data,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      //file that has to be sent
      if (image != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          image.path,
        );
        request.files.add(multipartFile);
      }
      
      // Send the request
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        print("Unable to add image ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
