import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:snap_n_go/core/constants/IP.dart';

Future<String> getTwilioToken(String roomName, String userEmail) async {
  final response = await http
      .post(
    Uri.parse(getIP() + 'rest/test/getTwilioToken'),
    headers: <String, String>{
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer " +
          'eyJhbGciOiJIUzUxMiJ9..d5l2RMHiAnHM_Pl7IMnfAGEmFCesWOt6KMdBs7330X1ndtaYNaQVnkzag_GKpAbZxpGCDuieTflCQJwIJNiCpw',
      "Content-Encoding": "gzip",
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{"roomName": roomName, "userEmail": userEmail}),
  )
      .catchError((error) {
    debugPrint("------------- ERROR -------------");
    debugPrint(error.toString());
  });
  dynamic data = jsonDecode(response.body);
  String token = data['accessToken'];

  return token;
}

// generic post request that takes the entity name to save
// and access token and the needed body and make an post request
// to http://quickeyIP/rest/entities/entityNameToSave
Future<dynamic> genericPost(String entityName, dynamic body) async {
  // getting the correct path to call
  final String url = getIP() + 'rest/entities/$entityName';
  // making the api call
  final dynamic response = await http
      .post(Uri.parse(url),
          headers: <String, String>{
            "Content-Encoding": "gzip",
            "content-type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(body))
      .catchError((error) {
    debugPrint("------------- ERROR -------------");
    debugPrint(error.toString());
  });
  return response;
}

// generic get request that takes the entity name to list
// and access token and make a get request
// to http://quickeyIP/rest/entities/entityNameToget/all
Future<dynamic> genericGet(String entityName) async {
  // print('token in service--> $token');
  // getting the correct path to call
  final String url = getIP() + 'rest/entities/$entityName/all';
  // print('url in service--> $url');
  // making the api call
  final dynamic response =
      await http.get(Uri.parse(url), headers: <String, String>{
    "Content-Encoding": "gzip",
    // "content-type": "application/json; charset=UTF-8",
  }).catchError((error) {
    debugPrint("------------- ERROR -------------");
    debugPrint(error.toString());
  });

  // print("RESPONSE IS = ${jsonDecode(response.body)}");

  return jsonDecode(response.body);
}

// method that uploads a file to the backend, returns a StreamedResponse
Future<StreamedResponse> upload(List<int> file) async {
  final String url = getIP() + 'file/upload';

  var uri = Uri.parse(url);

  var request = new http.MultipartRequest("POST", uri);
  request.files.add(await http.MultipartFile.fromBytes('file', file,
      contentType: new MediaType('application', 'octet-stream'),
      filename: "file_up"));

  request.fields.putIfAbsent('type', () => 'file');
  var response = await request.send();
  return response;
}
