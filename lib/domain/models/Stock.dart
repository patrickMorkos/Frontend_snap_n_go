import 'dart:convert';

import 'package:flutter/foundation.dart';

class Stock {
  dynamic id;
  dynamic name;
  List<dynamic> stockProducts;
  dynamic userId;
  dynamic address;
  Stock({
    required this.id,
    required this.name,
    required this.stockProducts,
    required this.userId,
    required this.address,
  });

  Stock copyWith({
    dynamic? id,
    dynamic? name,
    List<dynamic>? stockProducts,
    dynamic? userId,
    dynamic? address,
  }) {
    return Stock(
      id: id ?? this.id,
      name: name ?? this.name,
      stockProducts: stockProducts ?? this.stockProducts,
      userId: userId ?? this.userId,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'stockProducts': stockProducts,
      'userId': userId,
      'address': address,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      id: map['id'] ?? null,
      name: map['name'] ?? null,
      stockProducts: List<dynamic>.from(map['stockProducts']),
      userId: map['userId'] ?? null,
      address: map['address'] ?? null,
    );
  }

  // String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) => Stock.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Stock(id: $id, name: $name, stockProducts: $stockProducts, userId: $userId, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stock &&
        other.id == id &&
        other.name == name &&
        listEquals(other.stockProducts, stockProducts) &&
        other.userId == userId &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stockProducts.hashCode ^
        userId.hashCode ^
        address.hashCode;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": this.id != null ? this.id : null,
      "name": this.name != null ? this.name : null,
      "stockProducts": this.stockProducts != null ? this.stockProducts : null,
      "userId": this.userId != null ? this.userId : null,
      "address": this.address != null ? this.address : null,
    };
  }
}
