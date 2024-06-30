import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/res/components/bottom_checkout.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/cart/components/listview_product.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<Cart>> _carts;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _carts = cartViewModel.getAllCartByUserId(userId, context);
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    return FutureBuilder(
        future: _carts,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (cartViewModel.carts.isEmpty) {
              return Scaffold(
                  bottomNavigationBar: BottomCheckout(
                    title: "Mua hàng",
                    totalPayment:
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(0),
                    onTap: () {
                      // Navigator.pushNamed(context, RoutesName.confirmOrder);
                    },
                  ),
                  appBar: AppBar(
                    title: const Text("Giỏ hàng"),
                  ),
                  body: const Center(
                      child: Text(
                    "Không có sản phẩm nào trong giỏ hàng",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )));
            } else {
              List<Cart> list = cartViewModel.carts;
              double totalPayment = 0;
              for (var cart in list) {
                totalPayment += (cart.product.price -
                        cart.product.price * cart.product.discount / 100) *
                    cart.quantity;
              }
              return Scaffold(
                bottomNavigationBar: BottomCheckout(
                  title: "Mua hàng",
                  totalPayment:
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(totalPayment.toInt()),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.confirmOrder);
                  },
                ),
                appBar: AppBar(
                  title: const Text("Giỏ hàng"),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListViewProduct(items: list),
                      const SizedBox(
                        height: 12,
                      ),
                      // const BagTotalCheckout()
                    ],
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Giỏ hàng"),
                ),
                body: const Center(child: CircularProgressIndicator()));
          }
        });
  }
}
