import 'package:flutter/material.dart';
import 'package:shopelec/view/components/tabs/home_view.dart';

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
    HomeView(),
    Container(
      child: Center(
        child: Text("ORDER" , style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text("CART" , style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text("Favorite" , style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text("PROFILE" , style: TextStyle(fontSize: 30),),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome back"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button tap
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart button tap
            },
          ),
        ],
      ),
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
                icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
                label: "Order",
                icon: Icon(Icons.content_paste_search_sharp),
            ),
            BottomNavigationBarItem(
                label: "Cart",
                icon: Icon(Icons.shopping_cart_rounded),
            ),
            BottomNavigationBarItem(
                label: "Favorite",
                icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
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
