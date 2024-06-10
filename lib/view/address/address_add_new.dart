import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/res/components/round_button.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class AddressAddNew extends StatelessWidget {
  const AddressAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    final authViewModel = Provider.of<AuthViewModel>(context);
    final addressViewModel = Provider.of<AddressViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm địa chỉ mới"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesName.address);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: "Tên người nhận"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Hãy nhập tên người nhận";
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.call),
                        labelText: "Số điện thoại"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Hãy nhập số điện thoại";
                      }
                    },
                  ),
                  TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.location),
                          labelText: "Địa chỉ nhận"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Hãy nhập địa chỉ nhận";
                        }
                      }),
                  RoundButton(
                      title: "Lưu",
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "name": nameController.text,
                            "phoneNumber": phoneController.text,
                            "address": addressController.text,
                            "user_id": authViewModel.infoUserCurrent['id']
                          };
                          addressViewModel
                              .saveAddress(data, context)
                              .whenComplete(() =>
                                  Navigator.pushReplacementNamed(
                                      context, RoutesName.address));
                        }
                      })
                ],
              )),
        ),
      ),
    );
  }
}
