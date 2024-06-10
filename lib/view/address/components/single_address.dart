import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/model/address.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address, this.onTap});

  final Address address;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: address.isSelected
                ? Colors.blue.withOpacity(0.5)
                : Colors.transparent,
            border: Border.all(
                color: address.isSelected
                    ? Colors.transparent
                    : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  address.isSelected ? Iconsax.tick_circle5 : null,
                  color: address.isSelected ? Colors.black : Colors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(address.phone,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    address.address,
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
