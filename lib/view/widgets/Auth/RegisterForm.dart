import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/core/utils/validation.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/models/User.dart';

///This widget class is responsible of the RegisterForm() Content()
///It contains 5 TexFeild and 2 Button

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  //This variable is responsible of showing the password or hiding it
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  //This variable is responsible of storing the first name
  String firstName = '';

  //This variable is responsible of storing the last name
  String lastName = '';

  //This variable is responsible of storing the email
  String email = '';

  //This variable is responsible of storing the
  String dateOfBirth = '';

  //This variable is responsible of storing the password
  String password = '';

  //Those variables are responsible of validating the form
  bool isValidFirstname = false;
  bool isValidLastName = false;
  bool isValidEmail = false;
  bool isValidDateOfBirth = false;
  bool isValidPassword = true;
  bool isValidConfirmPassword = false;

  //This variable of type User() is responsible of storing the new registered
  //user
  User registeredUser = new User();

  //This variable is responsible for seeing if the button register is clicked so
  // we can check the form
  bool isChecking = false;

  //This function is responsible of registering the user to the backend
  void postRegisteredUser() {
    if (formIsValid()) {
      setState(() {
        registeredUser.firstName = firstName;
        registeredUser.lastName = lastName;  
        registeredUser.email = email;
        registeredUser.dateOdBirth = dateOfBirth;
        registeredUser.password = password;
      });
      print('User is succesfully registered==========>' +
          registeredUser.toString());
      print('User json format is=====================>' +
          jsonEncode(registeredUser).toString());
      genericPost2('Auth/register', jsonEncode(registeredUser).toString());
      // Get.toNamed('/');
    } else {
      print('Continue validation');
    }
  }

  //This function is responsible of validating the form
  bool formIsValid() {
    if (isValidFirstname == true &&
        isValidLastName == true &&
        isValidEmail == true &&
        isValidDateOfBirth == true &&
        isValidPassword == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TextField For the first name
        TextField(
          onChanged: (value) {
            setState(() {
              isValidFirstname = !isEmptyInput(value);
              firstName = value;
              if (value.length == 0) {
                isValidFirstname = false;
              }
            });
          },
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.red),
            counterText: isChecking == true && isValidFirstname == false
                ? 'First Name required'
                : '',
            hintText: 'First name',
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
        //TextField For the last name
        TextField(
          onChanged: (value) {
            setState(() {
              isValidLastName = !isEmptyInput(value);
              lastName = value;
              if (value.length == 0) {
                isValidLastName = false;
              }
            });
          },
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.red),
            counterText: isValidLastName == false && isChecking == true
                ? 'Last Name required'
                : '',
            hintText: 'Last name',
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
        //Date picker for the DOB
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                    child: Center(
                        child: dateOfBirth == ''
                            ? Text("Date of birth")
                            : Text(dateOfBirth))),
                onPressed: () async {
                  final DateTime? selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2035),
                  );
                  if (selected != null && selected != dateOfBirth) {
                    setState(() {
                      isValidDateOfBirth =
                          DateFormat('dd-MM-yyyy').format(selected) != '' &&
                                  isChecking == true
                              ? false
                              : true;
                      dateOfBirth = DateFormat('dd-MM-yyyy').format(selected);
                      // startDateControl = true;
                    });
                  }
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
            dateOfBirth == '' && isChecking == true
                ? Container(
                    padding: EdgeInsets.only(top: getSh(context) / 100),
                    child: Text(
                      'Date of birth required',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  )
                : Container(),
          ],
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
        //TextField For the confirm password
        TextFormField(
          onChanged: (value) {
            if (value == password) {
              setState(() {
                isValidConfirmPassword = true;
              });
            } else {
              setState(() {
                isValidConfirmPassword = false;
              });
            }
          },
          obscureText: isHiddenConfirmPassword,
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.red),
            counterText: isValidConfirmPassword == false && isChecking == true
                ? "Password don't match"
                : '',
            hintText: 'Confirm Password',
            suffixIcon: InkWell(
              onTap: () {
                if (isHiddenConfirmPassword == true) {
                  setState(() {
                    isHiddenConfirmPassword = false;
                  });
                } else {
                  setState(() {
                    isHiddenConfirmPassword = true;
                  });
                }
              },
              child: Icon(
                isHiddenConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
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
        //Button for the Register
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
                child: Center(child: Text("Register"))),
            onPressed: () {
              setState(() {
                isChecking = true;
              });
              postRegisteredUser();
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
