import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/main.dart';
import 'package:shopelec/repository/token_fcm_repository.dart';
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
  late FirebaseMessaging _firebaseMessaging;
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
  void initState() {
    super.initState();

     _firebaseMessaging = FirebaseMessaging.instance;

    final tokenRepo = TokenFCMRepository();

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      tokenRepo.saveToken(token!);
      tokenRepo.sendTokenToServer(token);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((String newToken) {
      tokenRepo.saveToken(newToken);
      tokenRepo.sendTokenToServer(newToken);
    });

    _subscribeToTopic();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      if (message.notification != null) {
        _showNotification(message.notification);
      }
    });
  }

  Future<void> _showNotification(RemoteNotification? notification) async {
    if (notification == null) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'normal_importance_channel', 
            'Normal Importance Notifications');

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, notification.title, notification.body, platformChannelSpecifics);
  }

  void _subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('all_users');
  }


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
