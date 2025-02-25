// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shopelec/model/brand.dart';
import 'package:shopelec/model/category.dart' as shopelec_category;
import 'package:shopelec/model/product_specification.dart';
import 'package:shopelec/model/review.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int discount;
  final int quantity;
  final String image_url;
  final String status;
  final bool favorite;
  final Brand brand;
  final shopelec_category.Category category;
  final List<ProductSpecification> specifications;
  final List<Review> reviews;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.image_url,
    required this.status,
    required this.favorite,
    required this.brand,
    required this.category,
    required this.specifications,
    required this.reviews,
  });
  

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? discount,
    int? quantity,
    String? image_url,
    String? status,
    bool? favorite,
    Brand? brand,
    shopelec_category.Category? category,
    List<ProductSpecification>? specifications,
    List<Review>? reviews,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
      image_url: image_url ?? this.image_url,
      status: status ?? this.status,
      favorite: favorite ?? this.favorite,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      specifications: specifications ?? this.specifications,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'image_url': image_url,
      'status': status,
      'favorite': favorite,
      'brand': brand.toMap(),
      'category': category.toMap(),
      'specifications': specifications.map((x) => x.toMap()).toList(),
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      discount: map['discount'] as int,
      quantity: map['quantity'] as int,
      image_url: map['image_url'] as String,
      status: map['status'] as String,
      favorite: map['favorite'] as bool,
      brand: Brand.fromMap(map['brand'] as Map<String,dynamic>),
      category: shopelec_category.Category.fromMap(map['category'] as Map<String,dynamic>),
      specifications: List<ProductSpecification>.from((map['specifications'] as List<dynamic>).map<ProductSpecification>((x) => ProductSpecification.fromMap(x as Map<String,dynamic>),),),
      reviews: List<Review>.from((map['reviews'] as List<dynamic>).map<Review>((x) => Review.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, discount: $discount, quantity: $quantity, image_url: $image_url, status: $status, favorite: $favorite, brand: $brand, category: $category, specifications: $specifications, reviews: $reviews)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.discount == discount &&
      other.quantity == quantity &&
      other.image_url == image_url &&
      other.status == status &&
      other.favorite == favorite &&
      other.brand == brand &&
      other.category == category &&
      listEquals(other.specifications, specifications) &&
      listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      discount.hashCode ^
      quantity.hashCode ^
      image_url.hashCode ^
      status.hashCode ^
      favorite.hashCode ^
      brand.hashCode ^
      category.hashCode ^
      specifications.hashCode ^
      reviews.hashCode;
  }
}
