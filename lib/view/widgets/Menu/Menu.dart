import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/utils/Authentication.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/controllers/LoginController.dart';
import 'package:snap_n_go/view/widgets/Menu/MenuItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final loginController= Get.put(LoginController());
  //This is the iniState() Function to trigger when the Menu() widget is rendered
  @override
  void initState() {
    super.initState();
    setState(() async {
      whichBtn = widget.isActive;
    });
  }

  bool isAuthenticated() {
    bool isLogged = false;
    isLoggedIn().then((value) => isLogged = value);
    return isLogged;
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
                  isMobileDevice()
                      ? MenuItem(
                          isActive: whichBtn == 1 ? true : false,
                          title: 'Scan now',
                          onTapCallBack: () {
                            print('About us');
                            setState(() {
                              whichBtn = 1;
                            });
                            Get.toNamed('/Scan');
                          })
                      : Container(),

                  isAuthenticated()
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
            InkWell(
              child: !isAuthenticated()
                  ? TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              loginController.userInfo['imageUrl']!= null ? NetworkImage(loginController.userInfo['imageUrl']!) : null,
                          child: loginController.userInfo['imageUrl'] == null
                              ? Icon(Icons.account_circle, size: 30)
                              : Container(),
                        ),
                        Text(
                          loginController.userInfo['username'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            logout();
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
