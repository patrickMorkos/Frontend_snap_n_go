// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/controllers/OpenFoodController.dart';
import 'package:snap_n_go/domain/models/Stock.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';
import 'package:snap_n_go/view/widgets/ListItem/SingleListItem.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the StockProducts() content
///It has a menu and the body of the StockProducts()

class StockProducts extends StatefulWidget {
  @override
  State<StockProducts> createState() => _StockProducts();
}

class _StockProducts extends State<StockProducts> {
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

  //This variable is for the list of products
  List<dynamic> productsData = [];

  //This variable check if the user is serching or not
  bool isSearching = false;

  //This variable holds the searched product value
  String searchedProduct = '';

  //This variable is to know if the searched product is found or not
  bool isProductFound = false;

  final foodController = Get.put(OpenFoodController());
  final searchController = TextEditingController();

  @override
  void initState() {
    //Getting the list of products from the backend using the genericGet function
    Future.delayed(
      Duration.zero,
      () async {
        dynamic list =
            await genericGet("StockManagement", "stock/" + stock.id.toString());
        setState(() {
          productsData = list;
        });
      },
    );

    //Handeling the received stock sent by the ManageStockScreen()
    try {
      setState(() {
        stock.id = Get.arguments['id'] != null ? Get.arguments['id'] : -1;
        stock.name = Get.arguments['name'] != null ? Get.arguments['name'] : '';
        stock.address =
            Get.arguments['address'] != null ? Get.arguments['address'] : '';
        print('THE CLICKED STOCK IS======>' + Get.arguments.toString());
      });
    } catch (e) {}
    print('IS THE PRODUCT FOUNT ===> ' + isProductFound.toString());
  }

  //Function for listing the products
  List<Widget> productsList() {
    List<SingleListItem> items = [];
    //Consition to check if the list is empty
    if (productsData.toString() != '[]') {
      items.add(
        SingleListItem(
          addBtnFunctionality: () {
            var stockProd = {
              "id": productsData[0]['id'].toString(),
              "stockId": productsData[0]['stockId'].toString(),
              "productId": productsData[0]['productId'].toString(),
              "quantity": (productsData[0]['quantity'] + 1).toString(),
              "expiryDate": productsData[0]['expiryDate'].toString(),
              "isdeleted": productsData[0]['isdeleted'].toString()
            };
            print('Product to be saved=======>' +
                jsonEncode(stockProd).toString());
            genericPut('StockManagement/' + productsData[0]['id'].toString(),
                jsonEncode(stockProd).toString());
          },
          removeBtnFunctionality: () {
            var stockProd = {
              "id": productsData[0]['id'].toString(),
              "stockId": productsData[0]['stockId'].toString(),
              "productId": productsData[0]['productId'].toString(),
              "quantity": (productsData[0]['quantity'] - 1).toString(),
              "expiryDate": productsData[0]['expiryDate'].toString(),
              "isdeleted": productsData[0]['isdeleted'].toString()
            };
            print('Product to be saved=======>' +
                jsonEncode(stockProd).toString());
            genericPut('StockManagement/' + productsData[0]['id'].toString(),
                jsonEncode(stockProd).toString());
          },
          itemHeader: "Name: " + productsData[0]['product']['name'].toString(),
          itemTitle: "Quantity: " + productsData[0]['quantity'].toString(),
          itemSubTitle:
              "Expiry Date: " + productsData[0]['expiryDate'].toString(),
        ),
      );
      if (productsData[0]['stock']?['stockProducts'].length > 0) {
        for (var i = 0;
            i < productsData[0]['stock']?['stockProducts'].length;
            i++) {
          items.add(
            SingleListItem(
              addBtnFunctionality: () {
                var stockProd = {
                  "id": productsData[0]['stock']['stockProducts'][i]['id']
                      .toString(),
                  "stockId": productsData[0]['stock']?['stockProducts'][i]
                          ?['stockId']
                      .toString(),
                  "productId": productsData[0]['stock']?['stockProducts'][i]
                          ?['productId']
                      .toString(),
                  "quantity": (productsData[0]['stock']?['stockProducts'][i]
                              ?['quantity'] +
                          1)
                      .toString(),
                  "expiryDate": productsData[0]['stock']?['stockProducts'][i]
                          ?['expiryDate']
                      .toString(),
                  "isdeleted": productsData[0]['stock']?['stockProducts'][i]
                          ?['isdeleted']
                      .toString()
                };
                print('Product to be saved=======>' +
                    jsonEncode(stockProd).toString());
                genericPut(
                    'StockManagement/' +
                        productsData[0]['stock']['stockProducts'][i]['id']
                            .toString(),
                    jsonEncode(stockProd).toString());
              },
              removeBtnFunctionality: () {
                var stockProd = {
                  "id": productsData[0]['stock']?['stockProducts'][i]?['id']
                      .toString(),
                  "stockId": productsData[0]['stock']?['stockProducts'][i]
                          ?['stockId']
                      .toString(),
                  "productId": productsData[0]['stock']?['stockProducts'][i]
                          ?['productId']
                      .toString(),
                  "quantity": (productsData[0]['stock']?['stockProducts'][i]
                              ?['quantity'] -
                          1)
                      .toString(),
                  "expiryDate": productsData[0]['stock']?['stockProducts'][i]
                          ?['expiryDate']
                      .toString(),
                  "isdeleted": productsData[0]['stock']?['stockProducts'][i]
                          ?['isdeleted']
                      .toString()
                };
                print('Product to be saved=======>' +
                    jsonEncode(stockProd).toString());
                genericPut(
                    'StockManagement/' +
                        productsData[0]['stock']['stockProducts'][i]['id']
                            .toString(),
                    jsonEncode(stockProd).toString());
              },
              itemHeader: "Name: " +
                  productsData[0]['stock']['stockProducts'][i]['product']
                          ['name']
                      .toString(),
              itemTitle: "Quantity: " +
                  productsData[0]['stock']['stockProducts'][i]['quantity']
                      .toString(),
              itemSubTitle: "Expiry Date: " +
                  productsData[0]['stock']['stockProducts'][i]['expiryDate']
                      .toString(),
            ),
          );
        }
      }
    }
    return items;
  }

  //Function that search for a product
  List<Widget> filteredProductsList() {
    List<SingleListItem> items = [];
    //Consition to check if the list is empty
    if (productsData.toString() != '[]') {
      if (productsData[0]['product']['name']
              .toString()
              .toLowerCase()
              .replaceAll(new RegExp(r"\s+"), "")
              .contains(searchedProduct
                  .toLowerCase()
                  .replaceAll(new RegExp(r"\s+"), "")) ||
          searchedProduct
              .toLowerCase()
              .replaceAll(new RegExp(r"\s+"), "")
              .contains(productsData[0]['product']['name']
                  .toString()
                  .toLowerCase()
                  .replaceAll(new RegExp(r"\s+"), ""))) {
        setState(() {
          isProductFound = true;
        });
        items.add(
          SingleListItem(
            addBtnFunctionality: () {
              var stockProd = {
                "id": productsData[0]['id'].toString(),
                "stockId": productsData[0]['stockId'].toString(),
                "productId": productsData[0]['productId'].toString(),
                "quantity": (productsData[0]['quantity'] + 1).toString(),
                "expiryDate": productsData[0]['expiryDate'].toString(),
                "isdeleted": productsData[0]['isdeleted'].toString()
              };
              print('Product to be saved=======>' +
                  jsonEncode(stockProd).toString());
              genericPut('StockManagement/' + productsData[0]['id'].toString(),
                  jsonEncode(stockProd).toString());
            },
            removeBtnFunctionality: () {
              var stockProd = {
                "id": productsData[0]['id'].toString(),
                "stockId": productsData[0]['stockId'].toString(),
                "productId": productsData[0]['productId'].toString(),
                "quantity": (productsData[0]['quantity'] - 1).toString(),
                "expiryDate": productsData[0]['expiryDate'].toString(),
                "isdeleted": productsData[0]['isdeleted'].toString()
              };
              print('Product to be saved=======>' +
                  jsonEncode(stockProd).toString());
              genericPut('StockManagement/' + productsData[0]['id'].toString(),
                  jsonEncode(stockProd).toString());
            },
            itemHeader:
                "Name: " + productsData[0]['product']['name'].toString(),
            itemTitle: "Quantity: " + productsData[0]['quantity'].toString(),
            itemSubTitle:
                "Expiry Date: " + productsData[0]['expiryDate'].toString(),
          ),
        );
      }
      if (productsData[0]['stock']?['stockProducts'].length > 0) {
        for (var i = 0;
            i < productsData[0]['stock']?['stockProducts'].length;
            i++) {
          if (productsData[0]['stock']['stockProducts'][i]['product']['name']
                  .toString()
                  .toLowerCase()
                  .replaceAll(new RegExp(r"\s+"), "")
                  .contains(searchedProduct
                      .toLowerCase()
                      .replaceAll(new RegExp(r"\s+"), "")) ||
              searchedProduct
                  .toLowerCase()
                  .replaceAll(new RegExp(r"\s+"), "")
                  .contains(productsData[0]['stock']['stockProducts'][i]
                          ['product']['name']
                      .toString()
                      .toLowerCase()
                      .replaceAll(new RegExp(r"\s+"), ""))) {
            setState(() {
              isProductFound = true;
            });
            items.add(
              SingleListItem(
                addBtnFunctionality: () {
                  var stockProd = {
                    "id": productsData[0]['stock']['stockProducts'][i]['id']
                        .toString(),
                    "stockId": productsData[0]['stock']?['stockProducts'][i]
                            ?['stockId']
                        .toString(),
                    "productId": productsData[0]['stock']?['stockProducts'][i]
                            ?['productId']
                        .toString(),
                    "quantity": (productsData[0]['stock']?['stockProducts'][i]
                                ?['quantity'] +
                            1)
                        .toString(),
                    "expiryDate": productsData[0]['stock']?['stockProducts'][i]
                            ?['expiryDate']
                        .toString(),
                    "isdeleted": productsData[0]['stock']?['stockProducts'][i]
                            ?['isdeleted']
                        .toString()
                  };
                  print('Product to be saved=======>' +
                      jsonEncode(stockProd).toString());
                  genericPut(
                      'StockManagement/' +
                          productsData[0]['stock']['stockProducts'][i]['id']
                              .toString(),
                      jsonEncode(stockProd).toString());
                },
                removeBtnFunctionality: () {
                  var stockProd = {
                    "id": productsData[0]['stock']?['stockProducts'][i]?['id']
                        .toString(),
                    "stockId": productsData[0]['stock']?['stockProducts'][i]
                            ?['stockId']
                        .toString(),
                    "productId": productsData[0]['stock']?['stockProducts'][i]
                            ?['productId']
                        .toString(),
                    "quantity": (productsData[0]['stock']?['stockProducts'][i]
                                ?['quantity'] -
                            1)
                        .toString(),
                    "expiryDate": productsData[0]['stock']?['stockProducts'][i]
                            ?['expiryDate']
                        .toString(),
                    "isdeleted": productsData[0]['stock']?['stockProducts'][i]
                            ?['isdeleted']
                        .toString()
                  };
                  print('Product to be saved=======>' +
                      jsonEncode(stockProd).toString());
                  genericPut(
                      'StockManagement/' +
                          productsData[0]['stock']['stockProducts'][i]['id']
                              .toString(),
                      jsonEncode(stockProd).toString());
                },
                itemHeader: "Name: " +
                    productsData[0]['stock']['stockProducts'][i]['product']
                            ['name']
                        .toString(),
                itemTitle: "Quantity: " +
                    productsData[0]['stock']['stockProducts'][i]['quantity']
                        .toString(),
                itemSubTitle: "Expiry Date: " +
                    productsData[0]['stock']['stockProducts'][i]['expiryDate']
                        .toString(),
              ),
            );
          }
        }
      }
    }
    return items;
  }

  //This Function of type widget returns the whole body of the StockProducts
  Widget _StockProductsBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: getSw(context) / 21,
                  right: getSw(context) / 21,
                ),
                width: getSw(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Header
                    Center(
                      child: Text(
                        'List of your products in `' + stock.name + '`',
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
                            Get.toNamed('/ManageStock');
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
                        //Scan search
                        Padding(
                          padding: EdgeInsets.only(right: getSw(context) / 100),
                          child: Container(
                            // width: getSw(context) / 4,
                            // height: getSh(context) / 13.5,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text for the product searched name
                                Container(
                                  // width: getSw(context) / 6,
                                  padding: EdgeInsets.only(
                                    left: getSw(context) / 225,
                                  ),
                                  child: Text(
                                    searchedProduct == ''
                                        ? 'Scan to Search'
                                        : searchedProduct,
                                    overflow: TextOverflow.ellipsis,
                                    style: searchedProduct == ''
                                        ? TextStyle(
                                            color: Colors.grey.shade600,
                                          )
                                        : TextStyle(
                                            color: PRIMARY_COLOR,
                                          ),
                                  ),
                                ),
                                //Scan icon
                                IconButton(
                                  icon: ImageIcon(
                                    AssetImage('assets/images/scan-search.png'),
                                    color: PRIMARY_COLOR,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: PRIMARY_COLOR,
                                          insetPadding: EdgeInsets.zero,
                                          shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          actions: [
                                            Container(
                                              // height: getSh(context) / 2,
                                              // width: getSh(context) / 2,
                                              // child: Text('Scan barcode'),
                                              child: Column(
                                                children: [
                                                  //Alert dialog Header
                                                  Center(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                        bottom:
                                                            getSh(context) / 50,
                                                        top:
                                                            getSh(context) / 50,
                                                      ),
                                                      child: Text(
                                                        'Scan barcode to search',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  //Consition if mobile device to performe a real scan on mobile
                                                  isMobileDevice()
                                                      ?
                                                      //Meanwhile empty container mobile version comming soon
                                                      Container()
                                                      :
                                                      //Web version scan search
                                                      Column(
                                                          children: [
                                                            //Input field for barcode
                                                            Container(
                                                              height: 50,
                                                              width: getSw(
                                                                      context) /
                                                                  7,
                                                              child: TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Barcode-UPC',
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                        25,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                controller:
                                                                    searchController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:
                                                                    (value) {
                                                                  if (value
                                                                          .length >
                                                                      3) {
                                                                    foodController
                                                                        .setBarcode(
                                                                            value);
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            //Search button
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: getSh(
                                                                        context) /
                                                                    30,
                                                                bottom: getSh(
                                                                        context) /
                                                                    30,
                                                              ),
                                                              child:
                                                                  CustomButton(
                                                                title: 'Search',
                                                                onTapCallBack:
                                                                    () async {
                                                                  print(
                                                                      'searching for product..');
                                                                  // await scanBarcode();
                                                                  // foodController.setBarcode('8024884500403');
                                                                  foodController.setBarcode(
                                                                      searchController
                                                                          .text
                                                                          .trim()
                                                                          .toString());
                                                                  await foodController
                                                                      .getProductInfoByBarcode();
                                                                  foodController
                                                                      .toggleScanMode();
                                                                  if (foodController
                                                                              .productInformation[
                                                                          'product_name'] ==
                                                                      null) {
                                                                    customAlert(
                                                                        context,
                                                                        'Error',
                                                                        'No such product barcode !',
                                                                        AlertType
                                                                            .error,
                                                                        Colors
                                                                            .red);
                                                                  } else {
                                                                    print(
                                                                        'READY?? ${foodController.isReady.value}');
                                                                    print(
                                                                        'INFOOOO: ${foodController.productInformation['product_name']}');
                                                                    setState(
                                                                        () {
                                                                      searchedProduct =
                                                                          foodController
                                                                              .productInformation['product_name'];
                                                                      isSearching =
                                                                          true;
                                                                      // Navigator.pop(
                                                                      //     context);
                                                                      // Get.toNamed(
                                                                      //     '/Products');
                                                                    });
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                'Next',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              onPressed: () {
                                                                if (isProductFound) {
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  Navigator.pop(
                                                                      context);
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        backgroundColor:
                                                                            PRIMARY_COLOR,
                                                                        insetPadding:
                                                                            EdgeInsets.zero,
                                                                        shape:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
                                                                        actions: [
                                                                          Container(
                                                                            // height: getSh(context) / 2,
                                                                            // width: getSh(context) / 2,
                                                                            // child: Text('Scan barcode'),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                //Alert dialog Header
                                                                                Center(
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.only(
                                                                                      bottom: getSh(context) / 50,
                                                                                      top: getSh(context) / 50,
                                                                                    ),
                                                                                    child: Text(
                                                                                      'Product not found',
                                                                                      style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Text('Do you want to add it?'),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        Get.toNamed('/AddProduct', arguments: [
                                                                                          stock.toJson(),
                                                                                          foodController.productInformation['product_name']
                                                                                        ]);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Yes',
                                                                                        style: TextStyle(
                                                                                          color: Colors.black,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(
                                                                                        'No',
                                                                                        style: TextStyle(
                                                                                          color: Colors.black,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    print('nw lets scan search');
                                  },
                                ),
                                //Clear search icon
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchedProduct = '';
                                      isSearching = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: PRIMARY_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSh(context) / 50,
                    ),
                    //Products list
                    Container(
                      height: getSh(context) / 1.7,
                      child: SingleChildScrollView(
                        child: Column(
                          children: isSearching
                              ? filteredProductsList()
                              : productsList(),
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
