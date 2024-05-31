// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Brand {
  final int id;
  final String name;

const Brand({
    required this.id,
    required this.name,
  });

  Brand copyWith({
    int? id,
    String? name,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Brand(id: $id, name: $name)';

  @override
  bool operator ==(covariant Brand other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
