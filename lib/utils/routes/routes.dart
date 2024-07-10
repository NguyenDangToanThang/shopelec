import 'package:flutter/material.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/model/brand.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/model/coupons.dart';
import 'package:shopelec/model/order.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/address/address_add_new.dart';
import 'package:shopelec/view/address/address_view.dart';
import 'package:shopelec/view/change_password/change_password_biometric.screen.dart';
import 'package:shopelec/view/change_password/change_password_screen.dart';
import 'package:shopelec/view/contact/contact_screen.dart';
import 'package:shopelec/view/detail_app/detail_app_screen.dart';
import 'package:shopelec/view/detail_product/detail_product_screen.dart';
import 'package:shopelec/view/home_screen.dart';
import 'package:shopelec/view/login/forgot_password_view.dart';
import 'package:shopelec/view/login/login_view.dart';
import 'package:shopelec/view/login/signup_view.dart';
import 'package:shopelec/view/order/confirm_order_screen.dart';
import 'package:shopelec/view/order/detail_order_screen.dart';
import 'package:shopelec/view/order/order_screen.dart';
import 'package:shopelec/view/policy/term_policy_screen.dart';
import 'package:shopelec/view/products/products_view.dart';
import 'package:shopelec/view/profile/profile_view.dart';
import 'package:shopelec/view/rate/rate_product_screen.dart';
import 'package:shopelec/view/review_product/product_reviews_screen.dart';
import 'package:shopelec/view/tabs/cart/cart_view.dart';
import 'package:shopelec/view/tabs/home/components/product_category_screen.dart';

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
      case RoutesName.changePasswordBiometric:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const ChangePasswordBiometricScreen());
      case RoutesName.productCategory:
        String name = arg as String;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductCategoryScreen(name: name));
      case RoutesName.productReviews:
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
                reviews: List.empty(),
                specifications: List.empty());
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductReviewsScreen(product: product));
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
      case RoutesName.orders:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OrderScreen());
      case RoutesName.policy:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TermsPolicyScreen());
      case RoutesName.detailApp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DetailAppScreen());
      case RoutesName.contact:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactScreen());
      case RoutesName.changePassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChangePasswordScreen());
      case RoutesName.detailOrder:
        Order order = arg is Order
            ? arg
            : Order(
                modifiedDate: DateTime.now(),
                id: 0,
                address: Address(
                    id: 0,
                    address: "",
                    isSelected: false,
                    name: "",
                    phone: "",
                    user_id: ""),
                coupons: Coupons(
                    id: -1,
                    code: "",
                    description: "",
                    discount: 0,
                    discountLimit: 0,
                    expiredDate: "",
                    quantity: 0,
                    status: ""),
                orderDate: DateTime.now(),
                status: "",
                totalPrice: 0);
        return MaterialPageRoute(
            builder: (BuildContext context) => OrderDetailsPage(order: order));
      case RoutesName.rate:
        Order order = arg is Order
            ? arg
            : Order(
                modifiedDate: DateTime.now(),
                id: 0,
                address: Address(
                    id: 0,
                    address: "",
                    isSelected: false,
                    name: "",
                    phone: "",
                    user_id: ""),
                coupons: Coupons(
                    id: -1,
                    code: "",
                    description: "",
                    discount: 0,
                    discountLimit: 0,
                    expiredDate: "",
                    quantity: 0,
                    status: ""),
                orderDate: DateTime.now(),
                status: "",
                totalPrice: 0);
        return MaterialPageRoute(
            builder: (BuildContext context) => RateProductScreen(order: order));
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
                reviews: List.empty(),
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
