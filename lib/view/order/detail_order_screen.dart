import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/detail.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/view/order/components/address_info_order.dart';
import 'package:shopelec/view/order/components/item_info_order.dart';
import 'package:shopelec/view/tabs/cart/components/bag_total_checkout.dart';
import 'package:shopelec/view_model/order_view_model.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.order});

  final Order order;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late Future<dynamic> details;

  @override
  void initState() {
    super.initState();

    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    details = orderViewModel.getAllOrderDetailByOrderId(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressInfoOrder(address: widget.order.address),
            const SizedBox(height: 12),
            FutureBuilder(
                future: details,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<Detail> details = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.all(6),
                              child: ItemInfoOrder(
                                  detail: details[index], index: index));
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
                  Text("SE500K",
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
            const SizedBox(height: 12),
            BagTotalCheckout(coupon: 100000),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
