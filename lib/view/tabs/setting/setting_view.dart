
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
              "Tài khoản",
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
                      'Thiết lập tài khoản',
                      style: Theme.of(context).textTheme.titleMedium
                  ),
                  const SizedBox(height: 12,),
                  ListTileAccountSetting(
                      text: "Danh sách địa chỉ",
                      subText: "Thiết lập địa chỉ nhận hàng",
                      iconsax: const Icon(Iconsax.home),
                      onTap: () => Navigator.pushNamed(context, RoutesName.address),
                  ),
                  const SizedBox(height: 12,),
                  ListTileAccountSetting(
                      text: "Giỏ hàng",
                      subText: "Thêm, xóa sản phẩm vào giỏ hàng và đặt hàng",
                      iconsax: const Icon(Iconsax.shopping_cart),
                      onTap: () => Navigator.pushNamed(context, RoutesName.cart),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                      text: "Hóa đơn",
                      subText: "Danh sách đơn hàng đang thực hiện và đã hoàn thành",
                      iconsax: Icon(Iconsax.bag_tick),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                    text: "Yêu thích",
                    subText: "Lưu các sản phẩm yêu thích",
                    iconsax: Icon(Iconsax.favorite_chart),
                  ),
                  const SizedBox(height: 12,),
                  const ListTileAccountSetting(
                    text: "Điều khoản và chính sách",
                    subText: "Thỏa thuận về điều khoản và chính sách",
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
                          'Đăng xuất',
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


