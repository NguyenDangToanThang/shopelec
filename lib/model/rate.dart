// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rate {
  final int id;
  final double rate;
  final String comment;
  final int productId;
  final String userId;
  Rate({
    required this.id,
    required this.rate,
    required this.comment,
    required this.productId,
    required this.userId,
  });

  Rate copyWith({
    int? id,
    double? rate,
    String? comment,
    int? productId,
    String? userId,
  }) {
    return Rate(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      comment: comment ?? this.comment,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rate': rate,
      'comment': comment,
      'productId': productId,
      'userId': userId,
    };
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map['id'] as int,
      rate: map['rate'] as double,
      comment: map['comment'] as String,
      productId: map['productId'] as int,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rate(id: $id, rate: $rate, comment: $comment, productId: $productId, userId: $userId)';
  }

  @override
  bool operator ==(covariant Rate other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.rate == rate &&
      other.comment == comment &&
      other.productId == productId &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      rate.hashCode ^
      comment.hashCode ^
      productId.hashCode ^
      userId.hashCode;
  }
}
