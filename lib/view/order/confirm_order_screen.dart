import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/model/coupons.dart';
import 'package:shopelec/res/components/bottom_checkout.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:shopelec/view/order/components/address_info_cart.dart';
import 'package:shopelec/view/order/components/item_confirm_order.dart';
import 'package:shopelec/view/order/components/item_coupons.dart';
import 'package:shopelec/view/tabs/cart/components/bag_total_checkout.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/cart_view_model.dart';
import 'package:shopelec/view_model/coupons_view_model.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final TextEditingController _couponsController = TextEditingController();

  late Future<Address> addressActive;

  late Future<dynamic> coupons0;

  late List<Cart> list;

  double total = 0.0;
  double coupon = 0.0;

  String couponText = "Chọn hoặc nhập mã";

  late Coupons coupons2;

  @override
  void initState() {
    super.initState();

    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    final couponsViewModel =
        Provider.of<CouponsViewModel>(context, listen: false);
    addressActive = addressViewModel
        .getAddressActive(FirebaseAuth.instance.currentUser!.uid);

    list = cartViewModel.carts;
    double totalOriginal = 0.0;
    double totalDiscount = 0.0;
    double totalPayment = 0.0;
    for (Cart cart in list) {
      totalOriginal += cart.product.price * cart.quantity;
      totalDiscount +=
          cart.product.discount * cart.product.price * cart.quantity / 100;
    }
    totalPayment = totalOriginal - totalDiscount;
    total = totalPayment;
    // couponsViewModel.setTotalPayment(totalPayment);
    coupons0 = couponsViewModel.getAllCoupons(total);
  }

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);
    final cartViewModel = Provider.of<CartViewModel>(context);
    return Scaffold(
      bottomNavigationBar: BottomCheckout(
        totalPayment: NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
            .format((total - coupon).toInt()),
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
            Container(
              height: 50,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(6),
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
              child: GestureDetector(
                onTap: () {
                  showCustomBottomSheet(context, total);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Iconsax.ticket,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 10),
                    const Text("Mã giảm giá",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    const Spacer(),
                    Text(couponText,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        )),
                    const SizedBox(width: 4),
                    Icon(
                      Iconsax.arrow_right_3,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            BagTotalCheckout(coupon: coupon),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context, double totalPayment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final couponsViewModel = Provider.of<CouponsViewModel>(context);
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Shop Electronics Voucher',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: _couponsController,
                          decoration: const InputDecoration(
                              labelText: 'Nhập mã voucher của Shop',
                              border: OutlineInputBorder()),
                          onSubmitted: (value) {
                            couponsViewModel
                                .checkCoupons(
                                    totalPayment, value.trim(), context)
                                .then((value) {
                              Coupons coupons = value;
                              if (coupons.status == "Đủ điều kiện") {
                          

                                setState(() {
                                  coupon = coupons.discount;
                                  couponText = coupons.code;
                                  coupons2 = coupons;
                                });
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              couponsViewModel
                                  .checkCoupons(totalPayment,
                                      _couponsController.text.trim(), context)
                                  .then((value) {
                                Coupons coupons = value;
                                if (coupons.status == "Đủ điều kiện") {
                                  

                                  setState(() {
                                    coupon = coupons.discount;
                                    couponText = coupons.code;
                                    coupons2 = coupons;
                                  });
                                  Navigator.pop(context);
                                } else {
                                  Utils.flushBarErrorMessage(
                                      "Mã ${coupons.status}", context);
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 65,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(child: Text("Áp dụng")),
                            ),
                          ))
                    ],
                  )),
              FutureBuilder(
                  future: coupons0,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List<Coupons>? list = snapshot.data;
                      return ListView.builder(
                          itemCount: list!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Coupons coupons = list[index];
                            return ItemCoupons(
                              coupon: coupons,
                              onTap: () {},
                            );
                          });
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.local_offer,
                                  size: 50, color: Colors.grey),
                              SizedBox(height: 16.0),
                              Text(
                                'Chưa có mã giảm giá nào của Shop',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Nhập mã giảm giá có thể sử dụng vào thanh bên trên',
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text(
                      'Đồng ý',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
