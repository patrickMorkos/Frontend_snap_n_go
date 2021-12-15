import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

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
