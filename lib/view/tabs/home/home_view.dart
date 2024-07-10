import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view/tabs/home/components/list_view_categories.dart';
import 'package:shopelec/view_model/product_view_model.dart';
import 'package:shopelec/view_model/store_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> categories = [
    {
      'title': 'Laptop',
      'image': 'assets/images/categories/icons8-laptop-96.png'
    },
    {
      'title': 'Điện thoại',
      'image': 'assets/images/categories/icons8-smartphone-96.png'
    },
    {
      'title': 'Tai nghe',
      'image': 'assets/images/categories/icons8-headphone-96.png'
    },
    {'title': 'Máy tính', 'image': 'assets/images/categories/icons8-pc-80.png'},
    {
      'title': 'Bàn phím',
      'image': 'assets/images/categories/icons8-keyboard-80.png'
    },
    {'title': 'Chuột', 'image': 'assets/images/categories/icons8-mouse-80.png'},
  ];

  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _products = productViewModel.getTopProduct(userId);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    Provider.of<StoreViewModel>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chào mừng đến với ShopElec"),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.cart);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Danh mục nổi bật',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.products);
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Tất cả',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.003,
                ),
                ListViewCategories(categories: categories, height: height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Sản phẩm nổi bật',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.products);
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Tất cả',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                FutureBuilder<List<Product>>(
                    future: _products,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        List<Product> products = snapshot.data!;
                        return GridProduct(products: products, length: 4);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString()); // display error
                      } else {
                        // ignore: prefer_const_constructors
                        return Center(
                            child:
                                CircularProgressIndicator()); // loader animation
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
