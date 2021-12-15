import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/view/widgets/Menu/MenuItem.dart';

///This widget class is responsible of the menu
///or in other words it is the AppBar() of our web app
///It contains a list of MenuItems()

class Menu extends StatefulWidget {
  int isActive;

  ///Those are the parameters of the Menu() widget class
  ///The parameter isActive is an integer varaiable and
  ///it is responsible of informing the Menu() widget which MenuItem is clicked
  ///
  Menu({Key? key, required this.isActive}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  //This Variable to check which button from the menu is clicked
  int whichBtn = -1;

  //This is the iniState() Function to trigger when the Menu() widget is rendered
  @override
  void initState() {
    super.initState();
    setState(() {
      whichBtn = widget.isActive;
    });
  }

  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSh(context) / 27),
      child: Container(
        padding: EdgeInsets.only(
            left: getSw(context) / 15, right: getSw(context) / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MenuItem(
                  isActive: whichBtn == 0 ? true : false,
                  title: 'Home',
                  onTapCallBack: () {
                    print('Home');
                    setState(() {
                      whichBtn = 0;
                    });
                    Get.toNamed('/');
                  },
                ),
                //MenuItem() for the HomeScreen()
                MenuItem(
                    isActive: whichBtn == 1 ? true : false,
                    title: 'Scan now',
                    onTapCallBack: () {
                      print('About us');
                      setState(() {
                        whichBtn = 1;
                      });
                      Get.toNamed('/Scan');
                    }),
                MenuItem(
                    isActive: whichBtn == 2 ? true : false,
                    title: 'Manage stock',
                    onTapCallBack: () {
                      print('Contact us');
                      setState(() {
                        whichBtn = 2;
                      });
                      Get.toNamed('/ManageStock');
                    }),
              ],
            ),
            Row(
              children: [
                //MenuItem() for the LoginScreen()
                MenuItem(
                  isActive: whichBtn == 4 ? true : false,
                  title: 'Login',
                  onTapCallBack: () {
                    print('SignIn');
                    setState(() {
                      whichBtn = 4;
                    });
                    Get.toNamed('/Login');
                  },
                ),
                //MenuItem() for the RegisterScreen()
                MenuItem(
                  isActive: whichBtn == 5 ? true : false,
                  title: 'Register',
                  onTapCallBack: () {
                    print('Register');
                    setState(() {
                      whichBtn = 5;
                    });
                    Get.toNamed('/Register');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
