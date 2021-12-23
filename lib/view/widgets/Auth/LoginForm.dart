import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
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
  bool isValidPassword = true;

  //This variable of type User() is responsible of storing the logged in user
  User loggedInUser = new User();

  Authentication auth = new Authentication(
    email: '',
    password: '',
  );

  //
  bool isChecking = false;

  //This function is responsible of loggin in the user
  void loginUser() {
    if (formIsValid()) {
      setState(() {
        loggedInUser.email = email;
        loggedInUser.password = password;
        auth.email = email;
        auth.password = password;
      });
      print(
          'User is succesfully loggedIn==========>' + loggedInUser.toString());
      print('User json format is=====================>' +
          loggedInUser.toJson().toString());
      login(auth);
      // Get.toNamed('/');
    } else {
      print('Continue validation');
    }
  }

  //This function is responsible of validating the form
  bool formIsValid() {
    if (isValidEmail == true) {
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
              isValidPassword = true;
              password = value;
              if (isPasswordValid(value)) {
                isValidPassword = true;
              }
            });
          },
          obscureText: isHiddenPassword,
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.red),
            counterText: isValidPassword == false && isChecking == true
                ? 'Enter a valid password'
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
      ],
    );
  }
}
