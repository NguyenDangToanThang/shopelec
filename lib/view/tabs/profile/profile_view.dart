
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/view/tabs/profile/components/list_tile_account_setting.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
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
                "Nguyen Dang Toan Thang",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                "nvbb802@gmail.com",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: IconButton(
                onPressed: () {

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
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Điều chỉnh giá trị để có góc bo tròn hợp lý
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


