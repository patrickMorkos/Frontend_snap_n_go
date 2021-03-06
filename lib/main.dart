// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:snap_n_go/core/navigation/Navigation.dart';
import 'package:snap_n_go/view/screens/HomeScreen.dart';

///This class the main of the website

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Snap and Go',
        getPages: Navigation().getNavigationList(),
        home: HomeScreen());
  }
}
