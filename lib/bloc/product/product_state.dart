import 'package:api_methods/models/product_model.dart';
import 'package:api_methods/utils/enums.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final List<ProductModel> productList;
  final String message;

  const ProductState({
    this.productStatus = ProductStatus.loading,
    this.productList = const <ProductModel>[],
    this.message = '',
  });

  ProductState copyWith({
    ProductStatus? productStatus,
    List<ProductModel>? productList,
    String? message,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      productList: productList ?? this.productList,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [productStatus, productList, message];
}
