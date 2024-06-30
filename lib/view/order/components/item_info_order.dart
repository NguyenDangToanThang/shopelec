import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopelec/model/detail.dart';

class ItemInfoOrder extends StatelessWidget {
  const ItemInfoOrder({super.key, required this.detail, required this.index});
  final Detail detail;
  final int index;

  @override
  Widget build(BuildContext context) {
    String priceDiscount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format((detail.price -
                detail.price * detail.discount / 100)
            .toInt());
    String price = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format((detail.price).toInt());
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 120,
              child: Center(
                child: Image.network(
                  detail.imageUrl,
                  fit: BoxFit.contain,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        priceDiscount,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          "x${detail.quantity}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
