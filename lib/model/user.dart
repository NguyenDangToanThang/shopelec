import 'dart:convert';
import 'package:flutter/material.dart';

User userJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@immutable // Recommended for value objects
class User {
  final String email;
  final String password;
  final String name;
  final String dateCreated;
  final String phoneNumber;
  final String role;

  const User({
    required this.email,
    required this.password,
    required this.name,
    required this.dateCreated,
    required this.phoneNumber,
    required this.role,
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json['email'] as String,
    password: json['password'] as String,
    name: json['name'] as String,
    dateCreated: json['date_created'],
    phoneNumber: json['phoneNumber'] as String,
    role: json['role'] as String,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'date_created': dateCreated,
    'phoneNumber': phoneNumber,
    'role': role,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              email == other.email &&
              password == other.password &&
              name == other.name &&
              dateCreated == other.dateCreated &&
              phoneNumber == other.phoneNumber &&
              role == other.role;

  @override
  int get hashCode => hashValues(
    email,
    password,
    name,
    dateCreated,
    phoneNumber,
    role,
  );

  @override
  String toString() =>
      'User(email: $email, password: $password, name: $name, dateCreated: $dateCreated, phoneNumber: $phoneNumber, role: $role)';
}