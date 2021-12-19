import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/utils/Authentication.dart';
import 'package:snap_n_go/core/utils/Common.dart';
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
        color: Colors.orange[300],
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
                        });
                      },
                      child: Text(
                        'Discover',
                        style: TextStyle(color: activeItem==0? Colors.white:Colors.black54),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    isMobileDevice()
                        ? InkWell(
                            onTap: () async{
                              setState(() {
                                activeItem = 1;
                              });
                              await Get.toNamed('/Scan');
                            },
                            child: Text(
                              'Scan Now',
                        style: TextStyle(color: activeItem==1? Colors.white:Colors.black54),
                            ),
                          )
                        : Container(),
                    isAuthenticated
                        ? InkWell(
                            onTap: () async{
                              setState(() {
                                activeItem = 1;
                              });
                              var destination='';
                              isAuthenticated? destination='/ManageStock':destination='/Login';
                              await Get.toNamed(destination);
                            },
                            child: Text(
                              'Manage your Stock',
                        style: TextStyle(color: activeItem==2? Colors.white:Colors.black54),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              isAuthenticated?
              InkWell(
                onTap: () {
                  setState(() {
                    activeItem = 2;
                  });
                  logout();
                },
                child: Text(
                  'Logout',
                        style: TextStyle(color: activeItem==3? Colors.white:Colors.black54),
                ),
              ):
              InkWell(
                onTap: ()async {
                  setState(() {
                    activeItem = 2;
                  });
                  await Get.toNamed('/Login');
                },
                child: Text(
                  'Login',
                        style: TextStyle(color: activeItem==3? Colors.white:Colors.black54),
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