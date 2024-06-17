import 'package:flutter/material.dart';
import 'package:shopelec/model/brand.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/address/address_add_new.dart';
import 'package:shopelec/view/address/address_view.dart';
import 'package:shopelec/view/detail_product/detail_product_screen.dart';
import 'package:shopelec/view/home_screen.dart';
import 'package:shopelec/view/login/forgot_password_view.dart';
import 'package:shopelec/view/login/login_view.dart';
import 'package:shopelec/view/login/signup_view.dart';
import 'package:shopelec/view/order/confirm_order_screen.dart';
import 'package:shopelec/view/products/products_view.dart';
import 'package:shopelec/view/profile/profile_view.dart';
import 'package:shopelec/view/review_product/product_reviews_screen.dart';
import 'package:shopelec/view/tabs/cart/cart_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordView());
      case RoutesName.productReviews:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProductReviewsScreen());
      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileView());
      case RoutesName.address:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddressView());
      case RoutesName.addressAddNew:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddressAddNew());
      case RoutesName.cart:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CartView());
      case RoutesName.confirmOrder:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ConfirmOrderScreen());
      case RoutesName.products:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProductsView());
      case RoutesName.detailProduct:
        Product product = arg is Product
            ? arg
            : Product(
                id: 0,
                name: "",
                price: 0,
                brand: const Brand(id: 0, name: "name"),
                category: Category(id: 0, name: "0"),
                description: "",
                discount: 0,
                image_url: "",
                quantity: 0,
                favorite: false,
                status: "",
                specifications: List.empty());
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                DetailProductScreen(product: product));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: const Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
