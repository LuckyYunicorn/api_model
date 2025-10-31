import 'package:api_methods/bloc/product/product_event.dart';
import 'package:api_methods/bloc/product/product_state.dart';
import 'package:api_methods/repository/product/product_repository.dart';
import 'package:api_methods/utils/enums.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository = ProductRepository();
  ProductBloc() : super(ProductState()) {
    on<ProductFetched>(_productFetched);
  }
  void _productFetched(ProductFetched event, Emitter<ProductState> emit) async {
    // emit(state.copyWith(productStatus: ProductStatus.loading));
    await productRepository
        .getProduct()
        .then((value) {
          emit(
            state.copyWith(
              productStatus: ProductStatus.success,
              productList: value,
              message: "Success",
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              productStatus: ProductStatus.error,
              message: error.toString(),
            ),
          );
        });
  }
}
