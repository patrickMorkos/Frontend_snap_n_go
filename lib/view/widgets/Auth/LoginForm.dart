import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Authentication.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/core/utils/validation.dart';
import 'package:snap_n_go/data/LoginService.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/entities/Authentication.dart';
import 'package:snap_n_go/domain/models/User.dart';

///This widget class is responsible of the LoginForm() Content()
///It contains 2 TexFeild and 1 Button

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //This variable is responsible of showing the password or hiding it
  bool isHiddenPassword = true;

  //This variable is responsible of storing the email
  String email = '';

  //This variable is responsible of storing the password
  String password = '';

  //Those variables are responsible of validating the form
  bool isValidEmail = false;
  bool isValidPassword = false;

  //This variable of type User() is responsible of storing the logged in user
  User loggedInUser = new User();

  //This variable is responsible to trigger when the login button is clicked
  //to check for validation
  bool isChecking = false;

  //This variable is responsible of the login status is valid or not credentials
  int isValidCredentials = -1;

  //This function is responsible of logging in the user
  void loginUser() async {
    if (formIsValid()) {
      late Authentication auth;
      setState(() {
        loggedInUser.email = email;
        loggedInUser.password = password;
        auth = new Authentication(
          email: email,
          password: password,
        );
      });
      //Calling the Login() function from the LoginService
      await Login(auth);
      String responseMessage =
          getResponseMessage().split('message:')[1].split('}')[0].toString();
      if (responseMessage == ' Invalid Credentials') {
        setState(() {
          isValidCredentials = 1;
        });
      } else {
        setState(() {
          isValidCredentials = 0;
        });
        dynamic res = await genericGet('Auth/user', '');
        print(res);
        Get.toNamed('/');
        switchStatus(true);
      }
    }
  }

  //This function is responsible of validating the form
  bool formIsValid() {
    if (isValidEmail == true && isValidPassword == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TextField For the email
        TextField(
          onChanged: (value) {
            setState(() {
              isValidEmail = isEmailValid(value);
              email = value;
            });
          },
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.red),
            counterText: isValidEmail == false && isChecking == true
                ? 'Enter a valid email'
                : '',
            hintText: 'Email',
            filled: true,
            fillColor: PRIMARY_COLOR,
            labelStyle: TextStyle(
                fontSize: getSw(context) / 266 + getSh(context) / 131.5),
            contentPadding: EdgeInsets.only(left: getSw(context) / 53.33),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: PRIMARY_COLOR),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: getSh(context) / 26.3),
        //TextField For the password
        TextFormField(
          onChanged: (value) {
            setState(() {
              isValidPassword = !isEmptyInput(value);
              password = value;
              if (value.length == 0) {
                isValidPassword = false;
              }
            });
          },
          obscureText: isHiddenPassword,
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.red),
            counterText: isValidPassword == false && isChecking == true
                ? 'Password is required'
                : '',
            hintText: 'Password',
            suffixIcon: InkWell(
              onTap: () {
                if (isHiddenPassword == true) {
                  setState(() {
                    isHiddenPassword = false;
                  });
                } else {
                  setState(() {
                    isHiddenPassword = true;
                  });
                }
              },
              child: Icon(
                isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: PRIMARY_COLOR,
            labelStyle: TextStyle(
                fontSize: getSw(context) / 266 + getSh(context) / 131.5),
            contentPadding: EdgeInsets.only(left: getSw(context) / 53.33),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: PRIMARY_COLOR),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: getSh(context) / 26.3),
        //Button for the Login
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Login btn
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: PRIMARY_COLOR,
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(child: Text("Login"))),
                onPressed: () {
                  setState(() {
                    isChecking = true;
                  });
                  loginUser();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade900,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            //The invalid credentials error text
            (isValidCredentials == 1 && isValidCredentials != 0) &&
                    isChecking == true &&
                    formIsValid() == true
                ? Container(
                    padding: EdgeInsets.only(top: getSh(context) / 100),
                    child: Text(
                      'Invalid Credentials',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  )
                : Container()
            // isValidCredentials=false && isChecking == true
            //     ? Container(
            //         padding: EdgeInsets.only(top: getSh(context) / 100),
            //         child: Text(
            //           'Date of birth required',
            //           textAlign: TextAlign.right,
            //           style: TextStyle(fontSize: 12, color: Colors.red),
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ],
    );
  }
}
