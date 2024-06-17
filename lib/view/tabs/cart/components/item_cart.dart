import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/res/components/quantity_input.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class ItemCart extends StatefulWidget {
  const ItemCart(
      {super.key, required this.cart, this.onTap, required this.index});

  final Cart cart;
  final void Function()? onTap;
  final int index;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    String priceDiscount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format((widget.cart.product.price -
                widget.cart.product.price * widget.cart.product.discount / 100)
            .toInt());
    String price = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format((widget.cart.product.price).toInt());
    int stock = widget.cart.product.quantity;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 140,
                child: Center(
                  child: Image.network(
                    widget.cart.product.image_url,
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          priceDiscount,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            price,
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(top: 6),
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 112,
                            child: QuantityInput(
                              maxVal: widget.cart.product.quantity,
                              initVal: widget.cart.quantity,
                              steps: 1,
                              onQtyChanged: (val) {
                                Cart cart = cartViewModel.carts[widget.index]
                                    .copyWith(quantity: val);
                                cartViewModel.setCartIndex(widget.index, cart);
                                cartViewModel.setQuantityInCart(
                                    val, widget.cart.id);
                              },
                            ),
                          ),
                          // Spacer(),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Còn $stock",
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
