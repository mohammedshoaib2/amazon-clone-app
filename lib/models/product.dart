// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/models/ratings.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      this.rating,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'images': images,
      'category': category,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      price: map['price'].toDouble(),
      quantity: map['quantity'].toDouble(),
      images: List<String>.from(map['images']),
      category: map['category'],
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']
                  .map(
                    (e) => Rating.fromMap(e),
                  )
                  .toList(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
