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
  late PageController _pageController; // Thêm PageController

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex, viewportFraction: 0.999);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final tabs = [
    const HomeView(),
    const StoreView(),
    // const CartView(),
    const FavoriteView(),
    const SettingView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: tabs,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.blue[200],
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
                label: "Trang chủ",
                icon: Icon(Iconsax.home),
            ),
            BottomNavigationBarItem(
                label: "Cửa hàng",
                icon: Icon(Iconsax.shop),
            ),
            // BottomNavigationBarItem(
            //     label: "Giỏ hàng",
            //     icon: Icon(Iconsax.shopping_cart),
            // ),
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
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            });
          },
      ),
    );
  }
}
