// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/view/widgets/Auth/LoginForm.dart';
import 'package:snap_n_go/view/widgets/Auth/RegisterForm.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the RegisterScreen() content
///It has a menu and the body of the RegisterScreen()

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  ///This variable is responsible on the register active button from the menu
  int whichBtn = 3;

  ///This Function of type widget returns the whole body of the RegisterScreen
  Widget _RegisterBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: getSw(context) / 21, right: getSw(context) / 21),
      child: Flex(
        direction: isLargeScreen(context) ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Container containing text and image
          Container(
            width:
                isLargeScreen(context) ? getSw(context) / 3.3 : getSw(context),
            child: Column(
              crossAxisAlignment: isLargeScreen(context)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                //Label of the LoginScreen
                Text(
                  'Welcome to `Snap n Go`',
                  style: TextStyle(
                    fontSize: getSw(context) / 71.11 + getSh(context) / 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: isLargeScreen(context)
                      ? TextAlign.left
                      : TextAlign.center,
                ),
                SizedBox(
                  height: getSh(context) / 26.3,
                ),
                //Label fot the register
                Text(
                  "If you already have an account",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                  textAlign: isLargeScreen(context)
                      ? TextAlign.left
                      : TextAlign.center,
                ),
                SizedBox(
                  height: getSh(context) / 80,
                ),
                //Row for the Login button
                Row(
                  mainAxisAlignment: isLargeScreen(context)
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Text(
                      "You can",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                      textAlign: isLargeScreen(context)
                          ? TextAlign.left
                          : TextAlign.center,
                    ),
                    SizedBox(width: getSw(context) / 106.66),
                    InkWell(
                      onTap: () {
                        print('Lets register');
                        Get.toNamed('/Login');
                      },
                      child: Text(
                        "Login from here!",
                        style: TextStyle(
                            color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
                        textAlign: isLargeScreen(context)
                            ? TextAlign.left
                            : TextAlign.center,
                      ),
                    ),
                  ],
                ),
                //Illustration 1
                isLargeScreen(context)
                    ? Padding(
                        padding: EdgeInsets.only(top: getSh(context) / 10),
                        child: Image.asset(
                          'images/food-scan.png',
                          width: getSw(context) / 5.33,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          //Illustration 2
          isLargeScreen(context)
              ? Image.asset(
                  'images/illustration-1.jpg',
                  width: getSw(context) / 5.33,
                )
              : Container(),
          //Register form
          Padding(
            padding: isLargeScreen(context)
                ? EdgeInsets.symmetric(vertical: getSh(context) / 6)
                : EdgeInsets.symmetric(vertical: getSh(context) / 12),
            child: Container(
              width:
                  isLargeScreen(context) ? getSw(context) / 5 : getSw(context),
              child: RegisterForm(),
            ),
          )
        ],
      ),
    );
  }

  //This is the build function of the RegisterScreen() widget class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: ListView(
        children: [
          Menu(
            isActive: whichBtn,
          ),
          _RegisterBody(context)
        ],
      ),
    );
  }
}
