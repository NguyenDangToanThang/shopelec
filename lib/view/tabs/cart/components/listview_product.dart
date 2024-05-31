import 'package:flutter/material.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/view/tabs/cart/components/item_cart.dart';

class ListViewProduct extends StatelessWidget {
  const ListViewProduct({
    super.key,
    required this.items
  });

  final List<Cart> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.fromBorderSide(BorderSide(color: Colors.grey.shade300))),
        child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCart(
                cart: item,
                onTap: () {},
              );
            }),
      ),
    );
  }
}
