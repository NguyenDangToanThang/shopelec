import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
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
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    int userId = authViewModel.infoUserCurrent['id'];
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
              if (snapshot.connectionState == ConnectionState.done) {
                List<Product> list = snapshot.data!;
                return GridProduct(products: list, length: list.length);
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
