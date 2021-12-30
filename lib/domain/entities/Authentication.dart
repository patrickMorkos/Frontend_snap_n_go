class Authentication {
  String? email;
  String? password;

  Authentication({required this.email, required this.password});

  Authentication.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['email'] = this.email!;
    data['password'] = this.password!;
    return data;
  }
}
