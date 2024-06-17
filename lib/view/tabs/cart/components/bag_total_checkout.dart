import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/cart.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class BagTotalCheckout extends StatelessWidget {
  const BagTotalCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            "Chi tiết thanh toán",
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 19),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                "Tổng tiền gốc",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(totalOriginal.toInt()),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "Tổng tiền được giảm",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Text(
                "-${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(totalDiscount.toInt())}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "Tổng tiền thanh toán",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(totalPayment.toInt()),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "Phí vận chuyển",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              const Text(
                "Miễn phí",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 1,
            height: 2,
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
