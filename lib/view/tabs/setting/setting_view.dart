import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/setting/components/list_tile_account_setting.dart';
import 'package:shopelec/view/tabs/setting/components/upload_avatar_provider.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final uploadProvider = Provider.of<UploadAvatarProvider>(context);

    final data = uploadProvider.currentUser;
    String? name = data!.displayName;
    String? email = data.email;
    String? urlImage = data.photoURL;
    // print(urlImage);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    await uploadProvider.pickImage().then((value) {
                      if (value != null && value) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Tải ảnh đại diện'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (uploadProvider.image != null)
                                    Image.file(
                                      uploadProvider.image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await uploadProvider.uploadImage();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tải ảnh'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Hủy'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: urlImage == null
                        ? const AssetImage("assets/images/avatar.png")
                        : NetworkImage(urlImage) as ImageProvider,
                  ),
                ),
                title: Text(
                  name!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Text(
                  email!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.profile);
                  },
                  icon: const Icon(
                    Iconsax.edit,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quản lý tài khoản',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileAccountSetting(
                      text: "Danh sách địa chỉ",
                      subText: "Thiết lập địa chỉ nhận hàng",
                      iconsax: const Icon(Iconsax.home),
                      onTap: () =>
                          Navigator.pushNamed(context, RoutesName.address),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileAccountSetting(
                      text: "Giỏ hàng",
                      subText: "Thêm, xóa sản phẩm vào giỏ hàng và đặt hàng",
                      iconsax: const Icon(Iconsax.shopping_cart),
                      onTap: () =>
                          Navigator.pushNamed(context, RoutesName.cart),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileAccountSetting(
                      text: "Đơn hàng",
                      subText:
                          "Danh sách đơn hàng đang thực hiện và đã hoàn thành",
                      iconsax: const Icon(Iconsax.bag_tick),
                      onTap: () =>
                          Navigator.pushNamed(context, RoutesName.orders),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Thông tin ứng dụng',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileAccountSetting(
                      text: "Điều khoản và chính sách",
                      subText: "Thỏa thuận về điều khoản và chính sách",
                      iconsax: const Icon(Iconsax.pen_tool),
                      onTap: () =>
                          Navigator.pushNamed(context, RoutesName.policy),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileAccountSetting(
                      text: "Thông tin ứng đụng và nhà phát triển",
                      subText:
                          "Hiển thị thông tin về phiên bản và nhà phát triển",
                      iconsax: const Icon(Iconsax.information),
                      onTap: () =>
                          Navigator.pushNamed(context, RoutesName.detailApp),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListTileAccountSetting(
                      text: "Liên hệ",
                      subText: "Một số phương thức liên hệ với quản trị viên",
                      iconsax: const Icon(Iconsax.link),
                      onTap: () =>
                          Navigator.pushNamed(context, RoutesName.contact),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                          side:
                              const BorderSide(width: 1.0, color: Colors.black),
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
      ),
    );
  }
}
