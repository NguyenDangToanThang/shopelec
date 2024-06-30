import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/address/components/single_address.dart';
import 'package:shopelec/view_model/address_view_model.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  late Future<List<Address>> _addressList;

  @override
  void initState() {
    super.initState();

    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);
    _addressList = addressViewModel
        .getAddressByUserId(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Danh sách địa chỉ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: _addressList,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Address> list = addressViewModel.addresses;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        Address address = list[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                              color: address.isSelected
                                  ? Colors.blue.withOpacity(0.5)
                                  : Colors.transparent,
                              border: Border.all(
                                  color: address.isSelected
                                      ? Colors.transparent
                                      : Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8)),
                          child: Slidable(
                            key: ValueKey(address.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    addressViewModel
                                        .removeFromAddress(address.id!);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Xóa',
                                )
                              ],
                            ),
                            child: SingleAddress(
                              address: address,
                              onTap: () {
                                setState(() {
                                  Map<String, dynamic> data = {
                                    "id": address.id.toString(),
                                    "name": address.name.toString(),
                                    "phoneNumber": address.phone.toString(),
                                    "address": address.address.toString(),
                                    "selected": true,
                                    "user_id": FirebaseAuth
                                        .instance.currentUser!.uid
                                        .toString()
                                  };
                                  addressViewModel.setActiveAddress(data);
                                  for (var i = 0; i < list.length; i++) {
                                    if (i == index) {
                                      list[i] =
                                          list[i].copyWith(isSelected: true);
                                      addressViewModel.setAddress(list[i]);
                                    } else {
                                      list[i] =
                                          list[i].copyWith(isSelected: false);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Bạn chưa thiết lập địa chỉ nào"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            child: const Icon(
              Iconsax.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutesName.addressAddNew);
            }));
  }
}
