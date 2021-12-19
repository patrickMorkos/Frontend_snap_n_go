import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:snap_n_go/domain/models/Product.dart';
import 'package:snap_n_go/domain/models/StockProduct.dart';

class Stock {
  final dynamic id;
  final dynamic name;
  final dynamic address;
  final List<dynamic> products;
  final List<dynamic> stockProducts;
  Stock({
    this.id,
    required this.name,
    required this.address,
    required this.products,
    required this.stockProducts,
  });



  Stock copyWith({
    dynamic? id,
    dynamic? name,
    dynamic? address,
    List<dynamic>? products,
    List<dynamic>? stockProducts,
  }) {
    return Stock(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      products: products ?? this.products,
      stockProducts: stockProducts ?? this.stockProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'products': products,
      'stockProducts': stockProducts,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      id: map['id'] ?? null,
      name: map['name'] ?? null,
      address: map['address'] ?? null,
      products: List<dynamic>.from(map['products']),
      stockProducts: List<dynamic>.from(map['stockProducts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) => Stock.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Stock(id: $id, name: $name, address: $address, products: $products, stockProducts: $stockProducts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Stock &&
      other.id == id &&
      other.name == name &&
      other.address == address &&
      listEquals(other.products, products) &&
      listEquals(other.stockProducts, stockProducts);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      products.hashCode ^
      stockProducts.hashCode;
  }
}
