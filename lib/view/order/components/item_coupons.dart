import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shopelec/model/coupons.dart';

class ItemCoupons extends StatelessWidget {
  const ItemCoupons({super.key, required this.coupon, this.onTap});

  final Coupons coupon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  "Giảm ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format((coupon.discount).toInt())}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "Đơn tối thiểu ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format((coupon.discountLimit).toInt())}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                // Text(
                //   "HSD: ${DateTime.parse(coupon.expiredDate).toString()}}",
                //   style: const TextStyle(fontSize: 14),
                // ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(child: Text("Lưu")),
          )
        ],
      ),
    );
  }
}
