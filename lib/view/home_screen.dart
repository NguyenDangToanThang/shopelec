import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    Container(
      child: Center(
        child: Text("HOME" , style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text("CART" , style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text("SETTING" , style: TextStyle(fontSize: 30),),
      ),
    ),
    Container(
      child: Center(
        child: Text("SETTING" , style: TextStyle(fontSize: 30),),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button tap
            },
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
                backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
                label: "Cart",
                icon: Icon(Icons.shopping_cart),
                backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
                label: "Setting",
                icon: Icon(Icons.person),
                backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
                backgroundColor: Colors.black
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
