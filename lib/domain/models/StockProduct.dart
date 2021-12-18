import 'dart:convert';

import 'package:snap_n_go/domain/models/Product.dart';
import 'package:snap_n_go/domain/models/Stock.dart';

class StockProduct {
  final dynamic id;
  final dynamic product;
  final dynamic stock;
  final dynamic quantity;
  StockProduct({
    required this.id,
    required this.product,
    required this.stock,
    required this.quantity,
  });

  StockProduct copyWith({
    dynamic? id,
    dynamic? product,
    dynamic? stock,
    dynamic? quantity,
  }) {
    return StockProduct(
      id: id ?? this.id,
      product: product ?? this.product,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'stock': stock,
      'quantity': quantity,
    };
  }

  factory StockProduct.fromMap(Map<String, dynamic> map) {
    return StockProduct(
      id: map['id'] ?? null,
      product: map['product'] ?? null,
      stock: map['stock'] ?? null,
      quantity: map['quantity'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockProduct.fromJson(String source) => StockProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StockProduct(id: $id, product: $product, stock: $stock, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StockProduct &&
      other.id == id &&
      other.product == product &&
      other.stock == stock &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      product.hashCode ^
      stock.hashCode ^
      quantity.hashCode;
  }
}
