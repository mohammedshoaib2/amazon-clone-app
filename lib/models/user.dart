// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String token;
  final String type;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.cart,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.token,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'token': token,
      'type': type,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']
            .map(
              (e) => Map<String, dynamic>.from(e),
            )
            .toList(),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? token,
    String? type,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      token: token ?? this.token,
      type: type ?? this.type,
      cart: cart ?? this.cart,
    );
  }
}
