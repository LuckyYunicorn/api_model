import 'dart:convert';

import 'package:api_methods/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductModel>> getProduct() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://dummyjson.com/products"),
      );

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        List<dynamic> decodedList = res['products'];

        List<ProductModel> productList = decodedList
            .map((e) => ProductModel.fromJson(e))
            .toList();

        // print("Product List ******************** ${productList[0].title}");

        return productList;
      } else {
        return <ProductModel>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
