import 'dart:convert';

import 'package:amazon_clone/models/product.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Order {
  final String id;
  final List<Product> productDetails;
  final double totalPrice;
  final String address;
  final int orderedAt;
  final int status;
  final String userId;
  final List<double> quantity;

  Order({
    required this.id,
    required this.productDetails,
    required this.totalPrice,
    required this.address,
    required this.orderedAt,
    required this.status,
    required this.userId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productDetails': productDetails.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'address': address,
      'orderedAt': orderedAt,
      'status': status,
      'userId': userId,
      'quantity': quantity,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'],
      productDetails: List<Product>.from(
        (map['productDetails']).map<Product>(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      totalPrice: map['totalPrice'].toDouble(),
      address: map['address'] as String,
      orderedAt: map['orderedAt'] as int,
      status: map['status'] as int,
      userId: map['userId'] as String,
      quantity: List<double>.from(
          map['productDetails'].map((e) => e['quantity'].toDouble())),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
