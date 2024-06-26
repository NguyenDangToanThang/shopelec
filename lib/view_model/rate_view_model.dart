

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/repository/rate_repository.dart';

class RateViewModel with ChangeNotifier {
  final _myRepo = RateRepository();
  final logger = Logger();

  Future<dynamic> saveRate(dynamic data) async {
    try {
      await _myRepo.saveRate(data);
    } catch (e) {
      logger.e(e.toString());
    }
  }


}
