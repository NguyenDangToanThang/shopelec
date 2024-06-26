import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopelec/firebase_options.dart';
import 'package:shopelec/repository/token_fcm_repository.dart';
import 'package:shopelec/utils/routes/routes.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:shopelec/view_model/cart_view_model.dart';
import 'package:shopelec/view_model/coupons_view_model.dart';
import 'package:shopelec/view_model/order_view_model.dart';
import 'package:shopelec/view_model/product_view_model.dart';
import 'package:shopelec/view_model/rate_view_model.dart';
import 'package:shopelec/view_model/store_view_model.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging _firebaseMessaging;

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

    FlutterNativeSplash.remove();
  }

  void _subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('all_users');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_token', token);
  }

  @override
  Widget build(BuildContext context) {
    bool checkLogin = FirebaseAuth.instance.currentUser != null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),
        ChangeNotifierProvider(create: (_) => CouponsViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => StoreViewModel()),
        ChangeNotifierProvider(create: (_) => RateViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: checkLogin ? RoutesName.home : RoutesName.login,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
