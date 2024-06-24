import 'package:flutter/material.dart';


class BottomCheckout extends StatefulWidget {
  const BottomCheckout(
      {super.key, required this.totalPayment, this.onTap, required this.title});

  final String totalPayment;
  final String title;
  final void Function()? onTap;

  @override
  State<BottomCheckout> createState() => _BottomCheckoutState();
}

class _BottomCheckoutState extends State<BottomCheckout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Tổng thanh toán: ",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: widget.totalPayment,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const Spacer(),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: const BoxDecoration(color: Colors.redAccent),
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
