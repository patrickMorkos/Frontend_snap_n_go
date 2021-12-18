import 'dart:convert';

class Product {
  final dynamic id;
  final dynamic name;
  final dynamic imgUrl;
  final dynamic category;
  Product({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.category,
  });

  Product copyWith({
    dynamic? id,
    dynamic? name,
    dynamic? imgUrl,
    dynamic? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? null,
      name: map['name'] ?? null,
      imgUrl: map['imgUrl'] ?? null,
      category: map['category'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, imgUrl: $imgUrl, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.id == id &&
      other.name == name &&
      other.imgUrl == imgUrl &&
      other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      imgUrl.hashCode ^
      category.hashCode;
  }
}
