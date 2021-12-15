import 'dart:convert';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? dateOdBirth;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dateOdBirth,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? dateOdBirth,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOdBirth: dateOdBirth ?? this.dateOdBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOdBirth': dateOdBirth,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      dateOdBirth: map['dateOdBirth'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password, dateOdBirth: $dateOdBirth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.password == password &&
        other.dateOdBirth == dateOdBirth;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        dateOdBirth.hashCode;
  }
}
