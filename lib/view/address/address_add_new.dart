import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddressAddNew extends StatelessWidget {
  const AddressAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm địa chỉ mới"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "Tên người nhận")),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "Số điện thoại")),
            ],
          )),
        ),
      ),
    );
  }
}
