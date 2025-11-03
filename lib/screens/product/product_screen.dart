import 'package:api_methods/bloc/product/product_bloc.dart';
import 'package:api_methods/bloc/product/product_event.dart';
import 'package:api_methods/bloc/product/product_state.dart';
import 'package:api_methods/screens/posts/post_screen.dart';
import 'package:api_methods/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = "/";
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductFetched()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Product Screen")),
        body: SafeArea(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              switch (state.productStatus) {
                case ProductStatus.loading:
                  return const Center(child: CircularProgressIndicator());

                case ProductStatus.success:
                  return ListView.builder(
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      final data = state.productList[index];
                      return _productCard(
                        images: data.thumbnail ?? '',
                        title: data.title ?? 'No Title',
                        description: data.description ?? 'No Description',
                      );
                    },
                  );

                case ProductStatus.error:
                  return Center(child: Text(state.message));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, PostScreen.routeName);
          },
          child: Icon(Icons.add),
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
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(images, height: 100, width: double.infinity),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(description, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}
