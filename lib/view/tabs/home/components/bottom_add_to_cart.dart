import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class BottomAddToCart extends StatefulWidget {
  const BottomAddToCart({super.key, required this.product});

  final Product product;

  @override
  State<BottomAddToCart> createState() => _BottomAddToCartState();
}

class _BottomAddToCartState extends State<BottomAddToCart> {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueGrey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Map<String, dynamic> cart = {
                  "product_id": widget.product.id,
                  "email": FirebaseAuth.instance.currentUser!.email,
                  "quantity": '1'
                };
                cartViewModel.addToCart(cart, context);
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
