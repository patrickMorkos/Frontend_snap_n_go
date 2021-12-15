// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the ScanScreen() content
///It has a menu and the body of the ScanScreen()

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  //This variable is responsible of the Scan screen active button from the menu
  int whichBtn = 1;

  //This Function of type widget returns the whole body of the ScanScreen
  Widget _ScanBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Container containing text and image
        Container(
          padding: EdgeInsets.only(
              left: getSw(context) / 21, right: getSw(context) / 21),
          // color: Colors.red,
          width: getSw(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This is the Scan Screen',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: ListView(
        children: [
          Menu(
            isActive: whichBtn,
          ),
          _ScanBody(context)
        ],
      ),
    );
  }
}
