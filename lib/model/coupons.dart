// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Coupons {
  int id;
  String code;
  String description;
  double discount;
  String expiredDate;
  double discountLimit;
  int quantity;
  String? status;

  Coupons({
    required this.id,
    required this.code,
    required this.description,
    required this.discount,
    required this.expiredDate,
    required this.discountLimit,
    required this.quantity,
    required this.status,
  });

  Coupons copyWith({
    int? id,
    String? code,
    String? description,
    double? discount,
    String? expiredDate,
    double? discountLimit,
    int? quantity,
    String? status,
  }) {
    return Coupons(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      expiredDate: expiredDate ?? this.expiredDate,
      discountLimit: discountLimit ?? this.discountLimit,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'description': description,
      'discount': discount,
      'expiredDate': expiredDate,
      'discountLimit': discountLimit,
      'quantity': quantity,
      'status': status,
    };
  }

  factory Coupons.fromMap(Map<String, dynamic> map) {
    return Coupons(
      id: map['id'] as int,
      code: map['code'] as String,
      description: map['description'] as String,
      discount: map['discount'] as double,
      expiredDate: map['expiredDate'] as String,
      discountLimit: map['discountLimit'] as double,
      quantity: map['quantity'] as int,
      status: map['status'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupons.fromJson(String source) =>
      Coupons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coupons(id: $id, code: $code, description: $description, discount: $discount, expiredDate: $expiredDate, discountLimit: $discountLimit, quantity: $quantity, status: $status)';
  }

  @override
  bool operator ==(covariant Coupons other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.description == description &&
        other.discount == discount &&
        other.expiredDate == expiredDate &&
        other.discountLimit == discountLimit &&
        other.quantity == quantity &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        description.hashCode ^
        discount.hashCode ^
        expiredDate.hashCode ^
        discountLimit.hashCode ^
        quantity.hashCode ^
        status.hashCode;
  }
}
