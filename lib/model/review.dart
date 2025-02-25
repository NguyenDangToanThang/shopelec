// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  final int id;
  final String comment;
  final double rate;
  final String dateCreated;
  final String email;
  final String name;
  final String image;
  Review({
    required this.id,
    required this.comment,
    required this.rate,
    required this.dateCreated,
    required this.email,
    required this.name,
    required this.image,
  });

  Review copyWith({
    int? id,
    String? comment,
    double? rate,
    String? dateCreated,
    String? email,
    String? name,
    String? image,
  }) {
    return Review(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      rate: rate ?? this.rate,
      dateCreated: dateCreated ?? this.dateCreated,
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'rate': rate,
      'date_created': dateCreated,
      'email': email,
      'name': name,
      'imageUrl': image,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as int,
      comment: map['comment'] as String,
      rate: map['rate'] as double,
      dateCreated: map['date_created'] as String,
      email: map['email'] != null ? map['email'] as String : "",
      name: map['name'] != null ? map['name'] as String : "",
      image: map['imageUrl'] != null ? map['imageUrl'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, comment: $comment, rate: $rate, dateCreated: $dateCreated, email: $email, name: $name, image: $image)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.comment == comment &&
        other.rate == rate &&
        other.dateCreated == dateCreated &&
        other.email == email &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        comment.hashCode ^
        rate.hashCode ^
        dateCreated.hashCode ^
        email.hashCode ^
        name.hashCode ^
        image.hashCode;
  }
}
