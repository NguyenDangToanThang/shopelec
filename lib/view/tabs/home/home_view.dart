
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/tabs/home/components/grid_product.dart';
import 'package:shopelec/view/tabs/home/components/list_view_categories.dart';
import 'package:shopelec/view/tabs/home/components/search_product.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> categories = [
    {'title': 'Laptop', 'image': 'assets/images/categories/laptop.png'},
    {'title': 'Phone', 'image': 'assets/images/categories/iphone.png'},
    {'title': 'Headphone', 'image': 'assets/images/categories/headphones.png'},
    {'title': 'Camera', 'image': 'assets/images/categories/camera.png'},
    {'title': 'Keyboard', 'image': 'assets/images/categories/keyboard.png'},
    {'title': 'Mouse', 'image': 'assets/images/categories/mouse.png'},
  ];

  List<Product> products = const [
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'Apple MacBook Pro Core i9 9th Gen',
      price: 224900,
      isFavorited: true
    ),
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'JBL T450BT Extra Bass Bluetooth Headset',
      price: 2799,
      isFavorited: false
    ),
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'Canon EOS 90D DSLR Camera Body with...',
      price: 113990,
      isFavorited: false
    ),
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'Samsung Galaxy M11 (Black, 32 GB)',
      price: 11270,
      isFavorited: true
    ),
  ];

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
              // const Text(
              //     'Find your product',
              //     style: TextStyle(
              //         color: Colors.black,
              //       fontWeight: FontWeight.w900,
              //       fontSize: 24
              //     ),
              // ),
              // SizedBox(height: height * 0.02,),
              const SearchProduct(),
              SizedBox(height: height * 0.02,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                      'Popular Categories',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          'More',
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
              SizedBox(height: height * 0.003,),
              ListViewCategories(categories: categories, height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Top Deals on Electronics',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          'More',
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
              GridProduct(products: products)
            ],
          ),
        ),
      ),
    );

  }
}

