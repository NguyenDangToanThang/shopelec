
import 'package:flutter/material.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/components/tabs/components/grid_product.dart';
import 'package:shopelec/view/components/tabs/components/item_categories.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});


  @override
  State<HomeView> createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> categories = [
    {'title': 'Laptop', 'image': 'assets/images/laptop.png'},
    {'title': 'Phone', 'image': 'assets/images/phone.png'},
    {'title': 'Laptop', 'image': 'assets/images/laptop.png'},
    {'title': 'Phone', 'image': 'assets/images/phone.png'},
    {'title': 'Laptop', 'image': 'assets/images/laptop.png'},
    {'title': 'Phone', 'image': 'assets/images/phone.png'},
    {'title': 'Laptop', 'image': 'assets/images/laptop.png'},
    {'title': 'Phone', 'image': 'assets/images/phone.png'},
  ];

  List<Product> products = const [
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'Apple MacBook Pro Core i9 9th Gen',
      price: 224900,
    ),
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'JBL T450BT Extra Bass Bluetooth Headset',
      price: 2799,
    ),
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'Canon EOS 90D DSLR Camera Body with...',
      price: 113990,
    ),
    Product(
      imageUrl: 'https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg',
      title: 'Samsung Galaxy M11 (Black, 32 GB)',
      price: 11270,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
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

              SizedBox(
                height: 80,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) {
                      final category = categories[index];
                      return item_categories(
                        height: height,
                        title: category['title'] as String,
                        image: category['image'] as String,
                        onTap: () {},
                      );
                    }
                ),
              ),

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
