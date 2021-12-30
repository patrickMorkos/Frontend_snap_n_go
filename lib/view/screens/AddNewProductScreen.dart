// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/models/Stock.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the AddNewProductScreen() content
///It has a menu and the body of the AddNewProductScreen()

class AddNewProduct extends StatefulWidget {
  @override
  State<AddNewProduct> createState() => _AddNewProduct();
}

class _AddNewProduct extends State<AddNewProduct> {
  //This variable is responsible of the Stock screen active button from the menu
  int whichBtn = 2;

  //This variable is the stock name that we'll get from the screen of ManageStock()
  Stock stock = new Stock(
    id: -1,
    name: '',
    stockProducts: [],
    userId: 1,
    address: '',
  );

  //This variable holds the products name
  String productName = '';

  //This variable holds the products name
  String productId = '';

  //This variable hold the quantity
  String quantity = '';

  //This variable hold the quantity
  String expiryDate = '';

  dynamic allProducts = [];

  @override
  void initState() {
    //Getting the list of products from the backend using the genericGet function
    Future.delayed(
      Duration.zero,
      () async {
        dynamic list = await genericGet("Product", "");
        print('ALL THE ARE1====>' + list.toString());

        setState(() {
          allProducts = list;
        });
      },
    );

    //Handeling the received stock sent by the StockProducts()
    try {
      print('Add new product screen-----------------------------------');
      print('THE RECEIVED STOCK IS============>' + Get.arguments[0].toString());
      Stock tmpStock = stock;
      tmpStock.id =
          Get.arguments[0]['id'] != null ? Get.arguments[0]['id'] : -1;
      tmpStock.name =
          Get.arguments[0]['name'] != null ? Get.arguments[0]['name'] : '';
      tmpStock.address = Get.arguments[0]['address'] != null
          ? Get.arguments[0]['address']
          : '';
      setState(() {
        stock = tmpStock;
        productName = Get.arguments[1].toString();
      });
    } catch (e) {}
    super.initState();
    print('STOCK WELL HANDLED===============>' + stock.toJson().toString());
  }

  //This Function of type widget returns the whole body of the StockProducts
  Widget _StockProductsBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.red,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                // color: Colors.green,
                padding: EdgeInsets.only(
                  left: getSw(context) / 21,
                  right: getSw(context) / 21,
                ),
                width: getSw(context),
                child: Column(
                  children: [
                    //Header
                    Center(
                      child: Text(
                        'Add Product to `' + stock.name + '`',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //Devider
                    Divider(
                      indent: getSw(context) / 100,
                      endIndent: getSw(context) / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Go back button
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/Products',
                              arguments: stock.toJson(),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getSw(context) / 100,
                            ),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ),
                        //Save product button
                        Padding(
                          padding: EdgeInsets.only(
                            right: getSw(context) / 100,
                          ),
                          child: CustomButton(
                            title: 'Save',
                            onTapCallBack: () {
                              for (int i = 0; i < allProducts.length; i++) {
                                if (allProducts[i]['name'] == productName) {
                                  print(allProducts[i]['id']);
                                  setState(() {
                                    productId = allProducts[i]['id'].toString();
                                  });
                                }
                              }
                              var prod = {
                                "stockId": stock.id.toString(),
                                "productId": productId.toString(),
                                "quantity": quantity.toString(),
                                "expiryDate": expiryDate.toString(),
                                "isdeleted": 0.toString()
                              };
                              print('Product to be saved=======>' +
                                  jsonEncode(prod).toString());
                              genericPost('StockManagement',
                                  jsonEncode(prod).toString());
                              Get.toNamed('/ManageStock',
                                  arguments: stock.toJson());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSh(context) / 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: PRIMARY_COLOR),
                      ),
                      // color: PRIMARY_COLOR,
                      // margin: EdgeInsets.only(
                      //     left: getSw(context) / 3, right: getSw(context) / 3),
                      child: Center(
                        child: Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            //Row for the product name
                            Container(
                              padding: EdgeInsets.only(
                                bottom: 10,
                                top: 10,
                                left: 10,
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Label for the product name
                                  Container(
                                    padding: EdgeInsets.only(right: 20),
                                    width: getSw(context) / 10,
                                    child: Text(
                                      'Product name',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  //The product name
                                  Container(
                                    alignment: Alignment.center,
                                    height: getSh(context) / 13.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.0),
                                      ),
                                      border: Border.all(color: PRIMARY_COLOR),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Text(
                                        productName,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Row for the product quantity
                            Container(
                              padding: EdgeInsets.only(bottom: 10, left: 10),
                              child: Row(
                                children: [
                                  //Label for the product quantity
                                  Container(
                                    width: getSw(context) / 10,
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      'Product Quantity',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  //The product quantity
                                  Container(
                                    alignment: Alignment.center,
                                    height: getSh(context) / 13.5,
                                    width: getSw(context) / 10,
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: PRIMARY_COLOR,
                                          ),
                                        ),
                                        hintText: 'Quantity',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          quantity = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Row for the Expiry date
                            Container(
                              padding: EdgeInsets.only(bottom: 10, left: 10),
                              child: Row(
                                children: [
                                  //Label for the product Expiry date
                                  Container(
                                    width: getSw(context) / 10,
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      'Product Expiry date',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  //The product expiry date
                                  Container(
                                    alignment: Alignment.center,
                                    height: getSh(context) / 13.5,
                                    width: getSw(context) / 10,
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: PRIMARY_COLOR,
                                          ),
                                        ),
                                        hintText: 'Expiry date dd-mm-yyy',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          expiryDate = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///This is the build function of the StockProduct() widget class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Container(
        child: Column(
          children: [
            Menu(
              isActive: whichBtn,
            ),
            _StockProductsBody(context)
          ],
        ),
      ),
    );
  }
}
