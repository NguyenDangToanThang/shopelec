import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/view/tabs/cart/components/address_info_cart.dart';
import 'package:shopelec/view/tabs/cart/components/bag_total_checkout.dart';
import 'package:shopelec/view/tabs/cart/components/listview_product.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

List<Cart> items = const [
  Cart(
    imageUrl:
        "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
    title: "Apple MacBook Pro Core i9 9th Gen2",
    discount: 10,
    stock: 2,
    price: 2000,
  ),
  Cart(
    imageUrl:
        "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
    title: "Apple MacBook Pro Core i9 9th Gen2",
    discount: 10,
    stock: 2,
    price: 2000,
  ),
  Cart(
    imageUrl:
        "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
    title: "Apple MacBook Pro Core i9 9th Gen2",
    discount: 10,
    stock: 2,
    price: 2000,
  ),
  Cart(
    imageUrl:
        "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
    title: "Apple MacBook Pro Core i9 9th Gen2",
    discount: 10,
    stock: 2,
    price: 2000,
  ),
];

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const AddressInfoCart(),

            const SizedBox(height: 8),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            Container(
              height: 8,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            const SizedBox(
              height: 12,
            ),
            
            ListViewProduct(items: items),
            
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            Container(
              height: 8,
              width: double.infinity,
              color: Colors.grey[200],
            ),  
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            
            const BagTotalCheckout()
          
          ],
        ),
      ),
    );
  }
}



