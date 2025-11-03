import 'dart:convert';

import 'package:api_methods/core/constants/api_urls.dart';
import 'package:api_methods/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductModel>> getProduct() async {
    try {
      http.Response response = await http.get(Uri.parse(ApiUrls.products));

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        List<dynamic> decodedList = res['products'];

        List<ProductModel> productList = decodedList
            .map((e) => ProductModel.fromJson(e))
            .toList();

        return productList;
      } else {
        return <ProductModel>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

//
// import 'dart:convert';
// import 'package:api_methods/core/constants/api_urls.dart';
// import 'package:api_methods/models/product_model.dart';
// import 'package:http/http.dart' as http;
//
// class ProductRepository {
//   Future<ProductModel> getProduct() async {
//     try {
//       final response = await http.get(Uri.parse(ApiUrls.products));
//
//       if (response.statusCode == 200) {
//         final res = jsonDecode(response.body);
//
//         final productModel = ProductModel.fromJson(res);
//
//         return productModel;
//       } else {
//         throw Exception("Failed to load products. Status Code: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching products: $e");
//     }
//   }
// }
