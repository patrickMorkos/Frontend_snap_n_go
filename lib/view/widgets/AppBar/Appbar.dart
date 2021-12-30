import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Authentication.dart';

//This widget is a custom AppBar

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  //This variable is to know which item in the appBar is clicked and active
  int activeItem = 0;

  //This variable is to save the status of the user if he is logged in or not
  bool isAuthenticated = false;

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
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: PRIMARY_COLOR,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          activeItem = 0;
                          Get.toNamed("/");
                        });
                      },
                      child: Text(
                        'Discover',
                        style: TextStyle(
                            color: activeItem == 0
                                ? Colors.white
                                : Colors.black54),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          activeItem = 1;
                          Get.toNamed('/Scan');
                        });
                      },
                      child: Text(
                        'Scan Now',
                        style: TextStyle(
                            color: activeItem == 1
                                ? Colors.white
                                : Colors.black54),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    isAuthenticated
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                activeItem = 2;
                              });
                              var destination = '';
                              isAuthenticated
                                  ? destination = '/ManageStock'
                                  : destination = '/Login';
                              await Get.toNamed(destination);
                            },
                            child: Text(
                              'Manage your Stock',
                              style: TextStyle(
                                  color: activeItem == 2
                                      ? Colors.white
                                      : Colors.black54),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              isAuthenticated
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          activeItem = 3;
                          Get.toNamed('/');
                          switchStatus(false);
                        });
                        // logout();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: activeItem == 3
                                ? Colors.white
                                : Colors.black54),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        setState(() {
                          activeItem = 4;
                        });
                        await Get.toNamed('/Login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: activeItem == 4
                                ? Colors.white
                                : Colors.black54),
                      ),
                    ),
              SizedBox(
                width: screenSize.width / 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
