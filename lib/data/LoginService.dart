// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:snap_n_go/core/constants/IP.dart';
import 'package:snap_n_go/domain/entities/Authentication.dart';

String responseMessage = '';

Future<dynamic> Login(Authentication authentication) async {
  var client = BrowserClient()..withCredentials = true; // <====
  http.Response response;
  final url = getIP() + "api/Auth/login";
  response = await client
      .post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(authentication.toJson()),
  )
      .catchError((error) {
    debugPrint("------------- ERROR ----------");
    debugPrint(error.toString());
  });
  dynamic data = jsonDecode(response.body);
  responseMessage = data.toString();
  return data;
}

String getResponseMessage() {
  return responseMessage;
}
