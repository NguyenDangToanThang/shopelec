import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/view_model/order_view_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key, required this.order, required this.tabController});

  final Order order;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    String textButton = '';
    String title = '';
    if (order.status == "Chờ giao hàng") {
      textButton = 'Đã nhận hàng';
      title = 'Đang giao hàng';
    } else if (order.status == "Chờ duyệt") {
      title = 'Đang chờ duyệt';
      textButton = 'Hủy đơn';
    } else if (order.status == "Đã giao") {
      title = 'Đã giao hàng';
      textButton = 'Đánh giá';
    } else {
      title = 'Đã hủy';
      textButton = 'Đặt lại đơn';
    }
    return Center(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      "Tổng: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format((order.totalPrice).toInt())}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd-MM-yyyy').format(order.orderDate),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_pin,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Mã đơn [#${order.id}]',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    int nextTabIndex = (tabController.index + 1);
                    if (order.status == "Chờ giao hàng") {
                      bool? confirmed = await showConfirmationDialog(context,
                          "Xác nhận đặt hàng và thanh toán cho người vận chuyển?");
                      if (confirmed != null && confirmed) {
                        Provider.of<OrderViewModel>(context, listen: false)
                            .updateStatusOrder(order.id, "Đã giao");
                        tabController.animateTo(nextTabIndex);
                      }
                    } else if (order.status == "Chờ duyệt") {
                      bool? confirmed = await showConfirmationDialog(context,
                          "Bạn có chắc chắn muốn hủy đơn hàng này không?");
                      if (confirmed != null && confirmed) {
                        Provider.of<OrderViewModel>(context, listen: false)
                            .updateStatusOrder(order.id, "Đã hủy")
                            .whenComplete(() => tabController
                                .animateTo(tabController.index + 3));
                        ;
                      }
                    } else if (order.status == "Đã giao") {
                      //tới trang chi tiết sản phẩm - có đánh giá riêng cho từng sản phẩm
                    } else {
                      bool? confirmed = await showConfirmationDialog(context,
                          "Bạn có chắc chắn muốn đặt lại đơn hàng này không?");
                      if (confirmed != null && confirmed) {
                        Provider.of<OrderViewModel>(context, listen: false)
                            .updateStatusOrder(order.id, "Chờ duyệt")
                            .whenComplete(() => tabController
                                .animateTo(tabController.index - 3));
                        ;
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(textButton),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(
      BuildContext context, String message) async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );

    return confirmed ?? false; // Nếu confirmed là null, trả về false
  }
}
