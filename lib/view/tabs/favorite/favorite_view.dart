import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();

    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _products = productViewModel.getAllFavoriteProductByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm yêu thích'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _products,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<Product> list = snapshot.data!;
                return GridProduct(products: list, length: list.length);
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("Không có sản phẩm yêu thích nào"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
      ),
    );
  }
}
