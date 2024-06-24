import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/coupons.dart';
import 'package:shopelec/repository/coupons_repository.dart';
import 'package:shopelec/utils/utils.dart';

class CouponsViewModel with ChangeNotifier {
  final _couponsRepo = CouponsRepository();
  final logger = Logger();

  CouponsViewModel() {
    _couponCheck = Coupons(
        id: -1,
        code: "",
        description: "",
        discount: 0,
        expiredDate: "",
        discountLimit: 0,
        quantity: 0,
        status: "");
    notifyListeners();
  }

  Coupons _couponCheck = Coupons(
      id: -1,
      code: "",
      description: "",
      discount: 0,
      expiredDate: "",
      discountLimit: 0,
      quantity: 0,
      status: "");

  Coupons get couponCheck => _couponCheck;

  void updateCouponCheck(Coupons coupons) {
    _couponCheck = coupons;
    notifyListeners();
  }

  Future<dynamic> getAllCoupons(double total) async {
    try {
      final json = await _couponsRepo.getAllCoupons(total);
      List<Coupons> response = parseCoupons(json);
      return response;
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<dynamic> checkCoupons(
      double totalPayment, String code, BuildContext context) async {
    try {
      final json = await _couponsRepo.checkCoupons(code, totalPayment);
      if (json['message'] == "Mã giảm giá không tồn tại") {
        Utils.flushBarErrorMessage(json['message'], context);
      } else {
        Coupons coupons = Coupons.fromMap(json);
        return coupons;
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  List<Coupons> parseCoupons(dynamic jsonList) {
    final List<dynamic> coupons = jsonList as List<dynamic>;
    return coupons
        .map((json) => Coupons.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
