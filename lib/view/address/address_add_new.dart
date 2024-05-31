import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddressAddNew extends StatelessWidget {
  const AddressAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "Name")),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "Phone Number")),
            ],
          )),
        ),
      ),
    );
  }
}
