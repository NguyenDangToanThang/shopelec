import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: selectedAddress
              ? Colors.blue.withOpacity(0.5)
              : Colors.transparent,
          border: Border.all(
              color:
                  selectedAddress ? Colors.transparent : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress ? Colors.black : Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Atomic",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text("0387185045",
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "KHC 8, Liên Bảo , TP Vĩnh Yên , Vĩnh Phúc",
                  softWrap: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
