// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sale {
  final int earning;
  final String label;

  Sale({required this.earning, required this.label});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'earning': earning,
      'label': label,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      earning: map['earning'].toInt(),
      label: map['label'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Sale.fromJson(String source) =>
      Sale.fromMap(json.decode(source) as Map<String, dynamic>);
}
