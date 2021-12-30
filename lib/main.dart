// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:snap_n_go/core/navigation/Navigation.dart';
import 'package:snap_n_go/domain/models/StockProduct.dart';
import 'package:snap_n_go/view/screens/HomeScreen.dart';
import 'package:snap_n_go/view/screens/StockProduct.dart';

///This class the main of the website

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Snap and Go',
        getPages: Navigation().getNavigationList(),
        home: HomeScreen());
  }
}
