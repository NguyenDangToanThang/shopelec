import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/res/components/round_button.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view_model/address_view_model.dart';

class AddressAddNew extends StatefulWidget {
  const AddressAddNew({super.key});

  @override
  State<AddressAddNew> createState() => _AddressAddNewState();
}

class _AddressAddNewState extends State<AddressAddNew> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    final addressViewModel = Provider.of<AddressViewModel>(context);
    String fullPhone = '';

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
                        labelText: "Tên người nhận",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Hãy nhập tên người nhận";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  IntlPhoneField(
                    disableLengthCheck: true,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    flagsButtonPadding: const EdgeInsets.all(8),
                    dropdownIconPosition: IconPosition.trailing,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'VN',
                    onChanged: (phone) {
                      fullPhone =
                          "${phone.countryCode}${phone.number.replaceFirst("0", "")}";
                    },
                    validator: (value) {
                      if (value!.completeNumber.isEmpty) {
                        return "Hãy nhập số điện thoại";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.location),
                        labelText: "Địa chỉ nhận",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Hãy nhập địa chỉ nhận";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundButton(
                      title: "Lưu",
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "name": nameController.text,
                            "phoneNumber": fullPhone,
                            "address": addressController.text,
                            "user_id": FirebaseAuth.instance.currentUser!.uid
                          };
                          addressViewModel.saveAddress(data, context);
                        }
                      })
                ],
              )),
        ),
      ),
    );
  }
}
