import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/view/tabs/cart/cart_view.dart';
import 'package:shopelec/view/tabs/home/home_view.dart';
import 'package:shopelec/view/tabs/profile/profile_view.dart';
import 'package:shopelec/view_model/auth_view_model.dart';

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
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final tabs = [
    const HomeView(),
    Container(
      child: Center(
        child: Text("ORDER" , style: TextStyle(fontSize: 30),),
      ),
    ),
    const CartView(),
    Container(
      child: Center(
        child: Text("Favorite" , style: TextStyle(fontSize: 30),),
      ),
    ),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    String username = authViewModel.getUserCurrent();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: tabs,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
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
                label: "Home",
                icon: Icon(Iconsax.home),
            ),
            BottomNavigationBarItem(
                label: "Order",
                icon: Icon(Iconsax.shop),
            ),
            BottomNavigationBarItem(
                label: "Cart",
                icon: Icon(Iconsax.shopping_cart),
            ),
            BottomNavigationBarItem(
                label: "Favorite",
                icon: Icon(Iconsax.favorite_chart),
            ),
            BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Iconsax.profile_2user),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            });
          },
      ),
    );
  }
}
