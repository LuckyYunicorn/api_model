import 'dart:convert';

import 'package:api_methods/core/constants/api_urls.dart';
import 'package:api_methods/models/post_req_model.dart';
import 'package:http/http.dart' as http;

class PostsRepository {
  Future<http.Response> addPosts({required PostsReqModel postReqModel}) async {
    try {
      print("PostReqMode: ${jsonEncode(postReqModel.toJson())}");
      http.Response response = await http.post(
        Uri.parse(ApiUrls.addPosts),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postReqModel.toJson()),
      );

      if (response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> fetchPosts() async {
    try {
      http.Response response = await http.get(Uri.parse(ApiUrls.fetchPosts));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> updatePosts({required String id,required String title}) async {
    try {
      Map<String,dynamic>data = {
        "title":title
      };
      http.Response response = await http.put(
        Uri.parse("${ApiUrls.fetchPosts}/$id"),
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
