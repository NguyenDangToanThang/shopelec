import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/firebase_options.dart';
import 'package:shopelec/utils/routes/routes.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/setting/components/upload_avatar_provider.dart';
import 'package:shopelec/view_model/address_view_model.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:shopelec/view_model/cart_view_model.dart';
import 'package:shopelec/view_model/coupons_view_model.dart';
import 'package:shopelec/view_model/order_view_model.dart';
import 'package:shopelec/view_model/product_view_model.dart';
import 'package:shopelec/view_model/rate_view_model.dart';
import 'package:shopelec/view_model/store_view_model.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
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
        ChangeNotifierProvider(create: (_) => UploadAvatarProvider()),
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
