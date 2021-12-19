// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:snap_n_go/core/navigation/Navigation.dart';
import 'package:snap_n_go/view/screens/HomeScreen.dart';

import 'core/utils/Authentication.dart';

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
  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }

    @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Snap and Go',
        getPages: Navigation().getNavigationList(),
        home: HomeScreen());
  }
}
