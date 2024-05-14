
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/setting/components/list_tile_account_setting.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {


  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    Map data = authViewModel.infoUserCurrent;
    String name = data['name'] ?? "";
    String email = data['email'] ?? "";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
              "Account",
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              // Handle cart button tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                    "assets/images/avatar.png",
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ) ,
              ),
              title: Text(
                name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                email,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.profile);
                },
                icon: const Icon(Iconsax.edit, color: Colors.black,),
              ),
            ),
            const SizedBox(height: 8,),

            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Account setting',
                      style: Theme.of(context).textTheme.titleMedium
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                      text: "My Addresses",
                      subText: "Set shopping delivery address",
                      iconsax: Icon(Iconsax.home),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                      text: "My Cart",
                      subText: "Add, remove products and move to checkout",
                      iconsax: Icon(Iconsax.shopping_cart),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                      text: "My Orders",
                      subText: "In-progress and Completed Orders",
                      iconsax: Icon(Iconsax.bag_tick),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                    text: "My Favorites",
                    subText: "Save favorite products",
                    iconsax: Icon(Iconsax.favorite_chart),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                    text: "Term and policy",
                    subText: "A Terms and Conditions agreement",
                    iconsax: Icon(Iconsax.pen_tool),
                  ),
                  const SizedBox(height: 12,),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        await authViewModel.logout(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                      child: Text(
                          'Logout',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


