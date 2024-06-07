import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/address/components/single_address.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Danh sách địa chỉ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SingleAddress(selectedAddress: false),
                SingleAddress(selectedAddress: true),
                SingleAddress(selectedAddress: false),
                SingleAddress(selectedAddress: false),
                SingleAddress(selectedAddress: false),
                SingleAddress(selectedAddress: false),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            child: const Icon(
              Iconsax.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.addressAddNew);
            }));
  }
}
