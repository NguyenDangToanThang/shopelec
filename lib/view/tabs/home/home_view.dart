import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view/tabs/home/components/list_view_categories.dart';
import 'package:shopelec/view/tabs/home/components/search_product.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> categories = [
    {'title': 'Laptop', 'image': 'assets/images/categories/laptop.png'},
    {'title': 'Điện thoại', 'image': 'assets/images/categories/iphone.png'},
    {'title': 'Tai nghe', 'image': 'assets/images/categories/headphones.png'},
    {'title': 'Máy ảnh', 'image': 'assets/images/categories/camera.png'},
    {'title': 'Bàn phím', 'image': 'assets/images/categories/keyboard.png'},
    {'title': 'Chuột', 'image': 'assets/images/categories/mouse.png'},
  ];

  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    _products = productViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    String name = authViewModel.infoUserCurrent['name'];
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              // Handle cart button tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SearchProduct(),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Danh mục nổi bật',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                      return CircularProgressIndicator(); // loader animation
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
