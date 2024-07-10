import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/detail.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/view/order/components/address_info_order.dart';
import 'package:shopelec/view/order/components/bag_total.dart';
import 'package:shopelec/view/order/components/item_info_order.dart';
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
      body: FutureBuilder(
          future: details,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<Detail> details = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    widget.order.status == "Đã giao"
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              style: Theme.of(context).textTheme.bodyLarge,
                              "Ngày nhận hàng: ${DateFormat('dd-MM-yyyy').format(widget.order.modifiedDate)}",
                            ))
                        : const SizedBox(),
                    widget.order.status == "Đã hủy"
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                                "Ngày hủy đơn: ${DateFormat('dd-MM-yyyy').format(widget.order.modifiedDate)}"),
                          )
                        : const SizedBox(),
                    (widget.order.status == "Đã giao" ||
                            widget.order.status == "Đã hủy")
                        ? const SizedBox(height: 6)
                        : const SizedBox(),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.all(6),
                              child: ItemInfoOrder(
                                  detail: details[index], index: index));
                        }),
                    AddressInfoOrder(address: widget.order.address),
                    const SizedBox(height: 12),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(
                          right: 6, left: 6, bottom: 6, top: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                          Text(
                              widget.order.coupons.id == -1
                                  ? "Không có mã giảm giá"
                                  : (widget.order.coupons.code).toString(),
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
                    const SizedBox(height: 6),
                    BagTotal(
                        coupon: widget.order.coupons.discount,
                        details: details),
                    const SizedBox(height: 6),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
