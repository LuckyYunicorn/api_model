import 'package:api_methods/bloc/product/product_bloc.dart';
import 'package:api_methods/bloc/product/product_event.dart';
import 'package:api_methods/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // @override
  // void initState() {
  //   context.read<ProductBloc>().add(ProductFetched());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductFetched()),
      child: Scaffold(
        appBar: AppBar(title: Text("Product Screen")),
        body: SafeArea(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  final data = state.productList[index];

                  switch (state.productStatus) {
                    case ProductStatus.loading:
                      return Center(child: CircularProgressIndicator());

                    case ProductStatus.success:
                      return _productCard(
                        images: data.images!.first,
                        title: data.title ?? "title",
                        description: data.description ?? "description",
                      );
                    case ProductStatus.error:
                      return Center(child: Text(state.message));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _productCard({
  required String images,
  required String title,
  required String description,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 100, child: Image.network(images)),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(description),
        ],
      ),
    ),
  );
}
