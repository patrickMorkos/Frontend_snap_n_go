import 'dart:convert';

class LoggedUser {
  final int? id;
  final String? email;
  final String? accessToken;
  final String? name;
  final String? imageUrl;
  LoggedUser({
    required this.id,
    this.email,
    this.accessToken,
    this.name,
    this.imageUrl,
  });

  LoggedUser copyWith({
    int? id,
    String? email,
    String? accessToken,
    String? name,
    String? imageUrl,
  }) {
    return LoggedUser(
      id: id ?? this.id,
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'accessToken': accessToken,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory LoggedUser.fromMap(Map<String, dynamic> map) {
    return LoggedUser(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      accessToken: map['accessToken'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoggedUser.fromJson(String source) =>
      LoggedUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoggedUser(id: $id, email: $email, accessToken: $accessToken, name: $name, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoggedUser &&
        other.id == id &&
        other.email == email &&
        other.accessToken == accessToken &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        accessToken.hashCode ^
        name.hashCode ^
        imageUrl.hashCode;
  }
}
