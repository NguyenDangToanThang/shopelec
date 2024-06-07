// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:shopelec/model/product.dart';

class Cart {
  final int id;
  final int quantity;
  final Product product;
  Cart({
    required this.id,
    required this.quantity,
    required this.product,
  });

  Cart copyWith({
    int? id,
    int? quantity,
    Product? product,
  }) {
    return Cart(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'productResponse': product.toMap(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      product: Product.fromMap(map['productResponse'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Cart(id: $id, quantity: $quantity, product: $product)';

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.quantity == quantity &&
      other.product == product;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode ^ product.hashCode;
}
