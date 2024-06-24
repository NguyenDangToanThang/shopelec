import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopelec/model/coupons.dart';

class ItemCoupons extends StatefulWidget {
  const ItemCoupons(
      {super.key,
      required this.coupon,
      required this.onTap,
      required this.couponCheck});

  final Coupons coupon;
  final Coupons couponCheck;
  final VoidCallback onTap;

  @override
  State<ItemCoupons> createState() => _ItemCouponsState();
}

class _ItemCouponsState extends State<ItemCoupons> {
  @override
  Widget build(BuildContext context) {

    DateFormat originalFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    DateTime dateTime = originalFormat.parse(widget.coupon.expiredDate);
    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17, bottom: 8, top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Giảm ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format((widget.coupon.discount).toInt())}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Đơn tối thiểu ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format((widget.coupon.discountLimit).toInt())}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "HSD: $formattedDate",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: CustomPaint(
                    painter: CircularCheckboxPainter(
                        widget.coupon.code == widget.couponCheck.code),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          border: Border.all(color: Colors.black45)),
                      width: 24,
                      height: 24,
                      child: widget.coupon.code == widget.couponCheck.code
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircularCheckboxPainter extends CustomPainter {
  final bool isChecked;

  CircularCheckboxPainter(this.isChecked);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Paint fillPaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;
    final Paint blankPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    // Fill the circle if checked
    if (isChecked) {
      canvas.drawCircle(Offset(radius, radius), radius, fillPaint);
    } else {
      canvas.drawCircle(Offset(radius, radius), radius, blankPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
