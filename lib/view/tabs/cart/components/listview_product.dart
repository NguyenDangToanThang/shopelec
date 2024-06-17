import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/view/tabs/cart/components/item_cart.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class ListViewProduct extends StatefulWidget {
  const ListViewProduct({super.key, required this.items});

  final List<Cart> items;

  @override
  State<ListViewProduct> createState() => _ListViewProductState();
}

class _ListViewProductState extends State<ListViewProduct>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // border:
          //     Border.fromBorderSide(BorderSide(color: Colors.grey.shade300))),
        ),
        child: ListView.builder(
            itemCount: widget.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final Cart item = widget.items[index];
              return Container(
                margin: const EdgeInsets.only(top: 8),
                child: Slidable(
                  key: ValueKey(item.id),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          cartViewModel.removeFromCart(item);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Xóa',
                      ),
                    ],
                  ),
                  child: ItemCart(
                    cart: item,
                    index: index,
                    onTap: () {},
                  ),
                ),
              );
            }),
      ),
    );
  }
}
