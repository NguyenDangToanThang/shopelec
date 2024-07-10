// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shopelec/model/address.dart';
import 'package:shopelec/model/coupons.dart';

class Order {
  final int id;
  final DateTime orderDate;
  final double totalPrice;
  final DateTime modifiedDate;
  final String status;
  final Address address;
  final Coupons coupons;
  Order({
    required this.id,
    required this.orderDate,
    required this.totalPrice,
    required this.status,
    required this.address,
    required this.coupons,
    required this.modifiedDate
  });

  Order copyWith({
    int? id,
    DateTime? orderDate,
    double? totalPrice,
    String? status,
    Address? address,
    Coupons? coupons,
    DateTime? modifiedDate,
  }) {
    return Order(
      id: id ?? this.id,
      orderDate: orderDate ?? this.orderDate,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      address: address ?? this.address,
      coupons: coupons ?? this.coupons,
      modifiedDate: modifiedDate ?? this.modifiedDate
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderDate': orderDate.millisecondsSinceEpoch,
      'modifiedDate': orderDate.millisecondsSinceEpoch,
      'totalPrice': totalPrice,
      'status': status,
      'addressResponse': address.toMap(),
      'coupons': coupons.toMap()
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      orderDate: map['orderDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['orderDate'])
          : DateTime.parse(map['orderDate']),
      totalPrice: map['totalPrice'] as double,
      status: map['status'] as String,
      modifiedDate: map['modifiedDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['modifiedDate'])
          : DateTime.parse(map['modifiedDate']),
      address: Address.fromMap(map['addressResponse'] as Map<String, dynamic>),
      coupons: Coupons.fromMap(map['coupons'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, orderDate: $orderDate, totalPrice: $totalPrice, status: $status, address: $address, coupons: $coupons)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderDate == orderDate &&
        other.totalPrice == totalPrice &&
        other.status == status &&
        other.address == address &&
        other.coupons == coupons;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderDate.hashCode ^
        totalPrice.hashCode ^
        status.hashCode ^
        address.hashCode ^
        coupons.hashCode;
  }
}
