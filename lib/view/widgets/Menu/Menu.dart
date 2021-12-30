import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/utils/Authentication.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/controllers/LoginController.dart';
import 'package:snap_n_go/view/widgets/Menu/MenuItem.dart';

///This widget class is responsible of the menu
///or in other words it is the AppBar() of our web app
///It contains a list of MenuItems()

class Menu extends StatefulWidget {
  int isActive;

  ///Those are the parameters of the Menu() widget class
  ///The parameter isActive is an integer varaiable and
  ///it is responsible of informing the Menu() widget which MenuItem is clicked
  Menu({Key? key, required this.isActive}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  //This Variable to check which button from the menu is clicked
  int whichBtn = -1;

  //This variable is to save the status of the user if he is logged in or not
  bool isAuthenticated = false;

  //This is the iniState() Function to trigger when the Menu() widget is rendered
  @override
  void initState() {
    super.initState();
    //Here we are checking the status of the user using the function isLoggedIn()
    var isAuth;
    Future.delayed(Duration.zero, () async {
      isAuth = await isLoggedIn();
      setState(() {
        isAuthenticated = isAuth;
      });
    }).then((value) => print('isAuthenticated: $isAuthenticated'));

    //Here we are activating the corresponding item from the menu
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Home screen menu item
                  MenuItem(
                    isActive: whichBtn == 0 ? true : false,
                    title: 'Discover',
                    onTapCallBack: () {
                      print('Home');
                      setState(() {
                        whichBtn = 0;
                      });
                      Get.toNamed('/');
                    },
                  ),
                  //Scan screen menu item
                  MenuItem(
                      isActive: whichBtn == 1 ? true : false,
                      title: 'Scan Now',
                      onTapCallBack: () {
                        setState(() {
                          whichBtn = 1;
                        });
                        Get.toNamed('/Scan');
                      }),
                  //Manage stock menu item that will appear only for authenticated users
                  isAuthenticated
                      ? MenuItem(
                          isActive: whichBtn == 2 ? true : false,
                          title: 'Manage stock',
                          onTapCallBack: () {
                            print('Manage stock');
                            setState(() {
                              whichBtn = 2;
                            });
                            Get.toNamed('/ManageStock');
                          })
                      : Container(),
                ],
              ),
            ),
            //Login menu item that will appear only for NOT authenticated users
            //Logout menu item that will appear only for authenticated users
            isAuthenticated
                //Logout menu item
                ? MenuItem(
                    title: 'Logout',
                    isActive: whichBtn == 3 ? true : false,
                    onTapCallBack: () {
                      setState(() {
                        whichBtn = 3;
                      });
                      switchStatus(false);
                      Get.toNamed('/Login');
                    },
                  )
                //Login menu item
                : MenuItem(
                    title: 'Login',
                    isActive: whichBtn == 3 ? true : false,
                    onTapCallBack: () {
                      setState(() {
                        whichBtn = 3;
                      });
                      Get.toNamed('/Login');
                    },
                  )
          ],
        ),
      ),
    );
  }
}
