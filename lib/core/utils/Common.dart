import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openfoodfacts/model/User.dart';

enum ScreenSize { Small, Normal, Large, ExtraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.ExtraLarge;
  if (deviceWidth > 600) return ScreenSize.Large;
  if (deviceWidth > 300) return ScreenSize.Normal;
  return ScreenSize.Small;
}

bool isMobileDevice() {
  return !kIsWeb && (Platform.isIOS || Platform.isAndroid);
}

bool isDesktopDevice() {
  return !kIsWeb &&
      (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
}

bool isWebDevice() {
  return kIsWeb;
}

// isLargeScreen(context) returns true if screen width >= 600
// it automatically adapts to orientation
bool isLargeScreen(context) => MediaQuery.of(context).size.width >= 600;

double getSw(context) => MediaQuery.of(context).size.width;

double getSh(context) => MediaQuery.of(context).size.height;

final storage = new FlutterSecureStorage();

dynamic readValue(String key) async{
  dynamic value=await storage.read(key: key);
  return value;
}

void storeValue(String key,dynamic value)async {
  await storage.write(key: key, value: value);
}

  // a registered user login for https://world.openfoodfacts.org/ is required
  User myUser = User(userId: 'matardani2@gmail.com', password: 'Dani.matar2');


