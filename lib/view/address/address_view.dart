import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/address/components/single_address.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

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
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _addressList = addressViewModel
        .getAddressByUserId(authViewModel.infoUserCurrent['id']);
  }

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Danh sách địa chỉ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: FutureBuilder(
            future: _addressList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<Address> list = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            Address address = list[index];
                            return SingleAddress(
                              address: address,
                              onTap: () {
                                setState(() {
                                  Map<String, dynamic> data = {
                                  "id": address.id,
                                  "name": address.name,
                                  "phoneNumber": address.phone,
                                  "isSelected": address.isSelected,
                                  "user_id": authViewModel.infoUserCurrent['id']
                                };
                                addressViewModel.setActiveAddress(data);
                                  for (var i = 0; i < list.length; i++) {
                                    if(i == index) {
                                      list[i].copyWith(isSelected: true);
                                    } else {
                                      list[i].copyWith(isSelected: false);
                                    }
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data == []) {
                return const Center(
                  child:
                      Text("Bạn chưa có địa chỉ giao hàng nào , hãy tạo mới"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
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
