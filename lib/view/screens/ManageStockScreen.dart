// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the ManageStock() content
///It has a menu and the body of the ManageStock()

class ManageStock extends StatefulWidget {
  @override
  State<ManageStock> createState() => _ManageStock();
}

class _ManageStock extends State<ManageStock> {
  //This variable is responsible of the Stock screen active button from the menu
  int whichBtn = 2;

  //This Function of type widget returns the whole body of the ManageStock
  Widget _ManageStockBody(BuildContext context) {
    return Container(
      child: Row(
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
                  'This is the ManageStock Screen',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          _ManageStockBody(context)
        ],
      ),
    );
  }
}
