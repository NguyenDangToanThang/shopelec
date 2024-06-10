import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shopelec/model/address.dart';
import 'package:shopelec/repository/address_repository.dart';
import 'package:shopelec/utils/utils.dart';

class AddressViewModel with ChangeNotifier {
  final _myRepo = AddressRepository();
  final logger = Logger();

  Future<List<Address>> getAddressByUserId(int userId) async {
    final jsonList;
    try {
      jsonList = await _myRepo.getAllAddressByUserId(userId);
      List<Address> response = parseAddresses(jsonList);
      return response;
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed to fetch addresses: $e");
    }
  }

  Future<Address> getAddressActive(int userId) async {
    try {
      final json = await _myRepo.getAllAddressByUserId(userId);
      Address response = Address.fromMap(json);
      return response;
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed to fetch addresses: $e");
    }
  }

  Future<dynamic> saveAddress(dynamic data, BuildContext context) async {
    try {
      await _myRepo.createAddress(data).then((value) {
        logger.i(value);
        Utils.flushBarSuccessMessage("Thêm mới địa chỉ thành công", context);
      });
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed saving address");
    }
  }

  Future<void> setActiveAddress(dynamic data) async {
    try {
      await _myRepo.setActive(data);
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Failed to set active address: $e");
    }
  }

  List<Address> parseAddresses(dynamic jsonList) {
    final List<dynamic> addressList = jsonList as List<dynamic>;
    return addressList
        .map((json) => Address.fromMap(json as Map<String, dynamic>))
        .toList();
  }
}
