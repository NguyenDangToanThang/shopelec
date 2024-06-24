// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderDetail {
  final int quantity;
  final int product_id;
  final int? order_id;
  OrderDetail({
    required this.quantity,
    required this.product_id,
    this.order_id,
  });

  OrderDetail copyWith({
    int? quantity,
    int? product_id,
    int? order_id,
  }) {
    return OrderDetail(
      quantity: quantity ?? this.quantity,
      product_id: product_id ?? this.product_id,
      order_id: order_id ?? this.order_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'product_id': product_id,
      'order_id': order_id,
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      quantity: map['quantity'] as int,
      product_id: map['product_id'] as int,
      order_id: map['order_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) => OrderDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderDetail(quantity: $quantity, product_id: $product_id, order_id: $order_id)';

  @override
  bool operator ==(covariant OrderDetail other) {
    if (identical(this, other)) return true;
  
    return 
      other.quantity == quantity &&
      other.product_id == product_id &&
      other.order_id == order_id;
  }

  @override
  int get hashCode => quantity.hashCode ^ product_id.hashCode ^ order_id.hashCode;
}
