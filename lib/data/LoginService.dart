import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:snap_n_go/core/constants/IP.dart';
import 'package:snap_n_go/domain/entities/Authentication.dart';
import 'package:snap_n_go/domain/entities/LoggedUser.dart';

Future<dynamic> login(Authentication authentication) async {
  LoggedUser logedUser;
  final url = getIP() + "login";
  final response = await http
      .post(
    Uri.parse(url),
    headers: <String, String>{
      "Content-Encoding": "gzip",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(authentication.toJson()),
  )
      .catchError((error) {
    debugPrint("------------- ERROR ----------");
    debugPrint(error.toString());
  });
  dynamic data = jsonDecode(response.body);

  logedUser = new LoggedUser(
      id: data['id'],
      email: data['email'],
      accessToken: data['token']['accessToken'],
);
  return logedUser;
}
