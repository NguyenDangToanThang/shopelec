import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/view/tabs/cart/components/address_info_cart.dart';
import 'package:shopelec/view/tabs/cart/components/bag_total_checkout.dart';
import 'package:shopelec/view/tabs/cart/components/listview_product.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late Future<List<Cart>> _carts;
  late Future<Address> _address;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);

    int userId = authViewModel.infoUserCurrent['id'];
    logger.i(authViewModel.infoUserCurrent['id']);
    _carts = cartViewModel.getAllCartByUserId(userId, context);
    _address = addressViewModel.getAddressActive(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
                future: _address,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return const Center(
                          child: Text("Bạn chưa có địa chỉ nhận"));
                    } else {
                      Address address = snapshot.data!;
                      return AddressInfoCart(address: address);
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
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
            FutureBuilder(
                future: _carts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Cart> list = snapshot.data!;
                    return ListViewProduct(items: list);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
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
