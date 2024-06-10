// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  final int id;
  final String address;
  final String name;
  final String phone;
  final bool isSelected;
  final int user_id;
  Address({
    required this.id,
    required this.address,
    required this.name,
    required this.phone,
    required this.isSelected,
    required this.user_id,
  });
  

  Address copyWith({
    int? id,
    String? address,
    String? name,
    String? phone,
    bool? isSelected,
    int? user_id,
  }) {
    return Address(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      isSelected: isSelected ?? this.isSelected,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'name': name,
      'phoneNumber': phone,
      'isSelected': isSelected,
      'user_id': user_id,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int,
      address: map['address'] as String,
      name: map['name'] as String,
      phone: map['phoneNumber'] as String,
      isSelected: map['isSelected'] as bool,
      user_id: map['user_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, address: $address, name: $name, phone: $phone, isSelected: $isSelected, user_id: $user_id)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.address == address &&
      other.name == name &&
      other.phone == phone &&
      other.isSelected == isSelected &&
      other.user_id == user_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      address.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      isSelected.hashCode ^
      user_id.hashCode;
  }
}
