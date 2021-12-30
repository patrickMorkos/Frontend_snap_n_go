import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openfoodfacts/model/User.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

dynamic readValue(String key) async {
  dynamic value = await storage.read(key: key);
  return value;
}

void storeValue(String key, dynamic value) async {
  await storage.write(key: key, value: value);
}

// a registered user login for https://world.openfoodfacts.org/ is required
User myUser = User(userId: 'matardani2@gmail.com', password: 'Dani.matar2');

Widget fadeAlertAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return Align(
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

customAlert(context, title, desc, type,textColor) {
  var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: textColor,
      ),
      // constraints: BoxConstraints.expand(width: 300),
      //First to chars "55" represents transparency of color
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.topCenter);
  Alert(
    context: context,
    type: type,
    style: alertStyle,
    title: title,
    desc: desc,
    alertAnimation: fadeAlertAnimation,
  ).show();
}

//Functin that returns the current system date
//in the format dd/mm/yyyy
String getSystemDate() {
  String now = DateTime.now().day.toString() +
      '-' +
      DateTime.now().month.toString() +
      '-' +
      DateTime.now().year.toString();
  return now;
}
