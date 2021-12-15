class LogedUser {
  late final int id;
  late final String email;
  late final String accessToken;
  List? profiles;
  List? permissions;

  LogedUser(
      {required this.id,
      required this.email,
      required this.accessToken,
      required this.profiles,
      required this.permissions});

  LogedUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    accessToken = json['accessToken'];
    permissions = json['permissions'];
    profiles = json['profiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['accessToken'] = this.accessToken;
    data['permissions'] = this.permissions;
    data['profiles'] = this.profiles;
    return data;
  }
}
