// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Detail {
  final int id;
  final int productId;
  final int quantity;
  final String name;
  final double price;
  final int discount;
  final String imageUrl;
  final bool rate;
  Detail({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.name,
    required this.price,
    required this.discount,
    required this.imageUrl,
    required this.rate,
  });

  Detail copyWith({
    int? id,
    int? productId,
    int? quantity,
    String? name,
    double? price,
    int? discount,
    String? imageUrl,
    bool? rate,
  }) {
    return Detail(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'name': name,
      'price': price,
      'discount': discount,
      'imageUrl': imageUrl,
      'status': rate,
    };
  }

  factory Detail.fromMap(Map<String, dynamic> map) {
    return Detail(
      id: map['id'] as int,
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      discount: map['discount'] as int,
      imageUrl: map['imageUrl'] as String,
      rate: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Detail.fromJson(String source) =>
      Detail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Detail(id: $id, productId: $productId, quantity: $quantity, name: $name, price: $price, discount: $discount, imageUrl: $imageUrl, rate: $rate)';
  }

  @override
  bool operator ==(covariant Detail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.name == name &&
        other.price == price &&
        other.discount == discount &&
        other.imageUrl == imageUrl &&
        other.rate == rate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        name.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        imageUrl.hashCode ^
        rate.hashCode;
  }
}
