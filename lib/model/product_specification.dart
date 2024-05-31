// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductSpecification {
  final int id;
  final String name;
  final String description;
  ProductSpecification({
    required this.id,
    required this.name,
    required this.description,
  });

  ProductSpecification copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return ProductSpecification(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ProductSpecification.fromMap(Map<String, dynamic> map) {
    return ProductSpecification(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSpecification.fromJson(String source) => ProductSpecification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductSpecification(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant ProductSpecification other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
