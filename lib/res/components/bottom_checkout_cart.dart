import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class BottomCheckoutCart extends StatefulWidget {
  const BottomCheckoutCart(
      {super.key, required this.totalPayment, this.onTap, required this.title});

  final String totalPayment;
  final String title;
  final void Function()? onTap;

  @override
  State<BottomCheckoutCart> createState() => _BottomCheckoutCartState();
}

class _BottomCheckoutCartState extends State<BottomCheckoutCart> {
  List<Cart> carts = List.empty();
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    carts = cartViewModel.carts;
    for (var cart in carts) {
      total += (cart.product.price -
              cart.product.price * cart.product.discount / 100) *
          cart.quantity;
    }
  }

  @override
  void dispose() {
    super.dispose();
    total = 0.0;
    carts = List.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Tổng thanh toán: ",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: carts.isEmpty
                          ? widget.totalPayment
                          : NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(total.toInt()),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const Spacer(),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: const BoxDecoration(color: Colors.redAccent),
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
