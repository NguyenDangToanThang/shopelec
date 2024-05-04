
import 'package:flutter/material.dart';

class BottomAddToCart extends StatefulWidget {
  const BottomAddToCart({super.key});

  @override
  State<BottomAddToCart> createState() => _BottomAddToCartState();
}

class _BottomAddToCartState extends State<BottomAddToCart> {
  @override
  Widget build(BuildContext context) {
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
                child:  const Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                )
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.black,
              ),
              child:  const Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
