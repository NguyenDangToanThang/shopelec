import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/utils/routes/routes_name.dart';

class AddressInfoCart extends StatelessWidget {
  const AddressInfoCart({
    super.key,
    required this.address,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        // border:
        //     Border.fromBorderSide(BorderSide(color: Colors.grey.shade300))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Địa chỉ nhận hàng",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 19)),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.address);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        // side: const BorderSide(
                        //     width: 1.0, color: Colors.blueAccent),
                      ),
                      child: Text(
                        'Thay đổi',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Vận chuyển tới ${address.name}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.call_received,
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      address.phone,
                      style: TextStyle(color: Colors.grey[800], fontSize: 15),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Iconsax.location,
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        address.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[800], fontSize: 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
