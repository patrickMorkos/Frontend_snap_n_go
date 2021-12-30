// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/view/widgets/Carousel/Carousel.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the HomeScreen() content
///It has a menu and the body of the HomeScreen()

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  //This variable is responsible of the Home screen active button from the menu
  int whichBtn = 0;

  //This Function of type widget returns the whole body of the HomeScreen
  Widget _HomeBody(BuildContext context) {
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
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getSw(context) / 21),
                    color: PRIMARY_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Text(
                  'Welcome to `Snap n Go`',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: getSh(context) / 5,
              ),
              ImageCarousel(
                items: [
                  Image.asset(
                    'images/mealscan.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'images/tellspec-chips.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'images/warehouseplanning.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'images/inventory_tracking_system.png',
                    fit: BoxFit.cover,
                  ),
                ],
              )
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
          Menu(isActive: whichBtn),
          _HomeBody(context),
        ],
      ),
    );
  }
}
