import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/view/tabs/favorite/favorite_view.dart';
import 'package:shopelec/view/tabs/home/home_view.dart';
import 'package:shopelec/view/tabs/setting/setting_view.dart';
import 'package:shopelec/view/tabs/store/store_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  static final tabs = [
    const HomeView(),
    const StoreView(),
    const FavoriteView(),
    const SettingView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.blue,
        selectedItemColor: Colors.pink,
        items: const [
          BottomNavigationBarItem(
            label: "Trang chủ",
            icon: Icon(Iconsax.home),
          ),
          BottomNavigationBarItem(
            label: "Cửa hàng",
            icon: Icon(Iconsax.shop),
          ),
          BottomNavigationBarItem(
            label: "Yêu thích",
            icon: Icon(Iconsax.favorite_chart),
          ),
          BottomNavigationBarItem(
            label: "Hồ sơ",
            icon: Icon(Iconsax.profile_2user),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
