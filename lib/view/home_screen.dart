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
        items: [
          BottomNavigationBarItem(
            label: "Trang chủ",
            icon: _buildIcon(Iconsax.home, 0),
          ),
          BottomNavigationBarItem(
            label: "Cửa hàng",
            icon: _buildIcon(Iconsax.shop, 1),
          ),
          BottomNavigationBarItem(
            label: "Yêu thích",
            icon: _buildIcon(Iconsax.favorite_chart, 2),
          ),
          BottomNavigationBarItem(
            label: "Hồ sơ",
            icon: _buildIcon(Iconsax.profile_2user, 3),
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

  Widget _buildIcon(IconData iconData, int index) {
    return Container(
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? Colors.pink.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        iconData,
      ),
    );
  }
}
