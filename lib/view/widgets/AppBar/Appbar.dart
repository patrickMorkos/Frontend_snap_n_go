import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Authentication.dart';
import 'package:snap_n_go/data/apiService.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int activeItem = 0;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    var isAuth;
    Future.delayed(Duration.zero, () async {
      isAuth = await isLoggedIn();
      // print('isAuth $isAuth');
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
          child: Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            activeItem = 0;
                          });
                          await Get.toNamed("/");
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
                        onTap: () async {
                          setState(() {
                            activeItem = 1;
                          });
                          await Get.toNamed('/Scan');
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
                                'Management',
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
                          });
                          logout();
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
                            activeItem = 2;
                          });
                          await Get.toNamed('/Login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: activeItem == 3
                                  ? Colors.white
                                  : Colors.black54),
                        ),
                      ),
                // SizedBox(
                //   width: screenSize.width / 50,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
