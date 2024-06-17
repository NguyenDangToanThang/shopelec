import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/res/components/bottom_checkout.dart';
import 'package:shopelec/view/order/components/address_info_cart.dart';
import 'package:shopelec/view/order/components/item_confirm_order.dart';
import 'package:shopelec/view/tabs/cart/components/bag_total_checkout.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  late Future<Address> addressActive;

  @override
  void initState() {
    super.initState();

    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);
    addressActive = addressViewModel
        .getAddressActive(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);
    final cartViewModel = Provider.of<CartViewModel>(context);
    double totalOriginal = 0;
    double totalDiscount = 0;
    double totalPayment = 0;
    List<Cart> list = cartViewModel.carts;
    for (Cart cart in list) {
      totalOriginal += cart.product.price * cart.quantity;
      totalDiscount +=
          cart.product.discount * cart.product.price * cart.quantity / 100;
    }
    totalPayment = totalOriginal - totalDiscount;
    return Scaffold(
      bottomNavigationBar: BottomCheckout(
        totalPayment: NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
            .format(totalPayment.toInt()),
        title: "Đặt hàng",
        onTap: () {},
      ),
      appBar: AppBar(
        title: const Text('Xác nhận đặt hàng'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: addressActive,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Address? address = snapshot.data;
                    if (address == null) {
                      return const Center(
                        child: Text("Chưa có địa chỉ nhận hàng"),
                      );
                    } else {
                      return AddressInfoCart(address: addressViewModel.address);
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            const SizedBox(height: 12),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartViewModel.carts.length,
                itemBuilder: (context, index) {
                  Cart cart = cartViewModel.carts[index];
                  return Container(
                      margin: const EdgeInsets.all(6),
                      child: ItemConfirmOrder(cart: cart, index: index));
                }),
            const SizedBox(height: 12),
            const BagTotalCheckout(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
