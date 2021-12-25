// ignore_for_file: non_constant_identifier_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/models/Product.dart';
import 'package:snap_n_go/domain/models/Stock.dart';
import 'package:snap_n_go/view/widgets/AppBar/Appbar.dart';
import 'package:snap_n_go/view/widgets/CardsList/CardsList.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';
import 'package:snap_n_go/view/widgets/ListItem/SingleListItem.dart';

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
  String stockName = 'Warehouse';

  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  FileType _pickingType = FileType.any;
  final extensionController = TextEditingController();

  //This variable is for the list of products
  List<dynamic> productsData = [
    {
      "productName": "Apple",
      "quantity": "10",
      "categoryName": "Fruits",
    },
    {
      "productName": "Avocado",
      "quantity": "4",
      "categoryName": "Fruits",
    },
    {
      "productName": "Eggs",
      "quantity": "5",
      "categoryName": "Diary",
    },
    {
      "productName": "Yogurt",
      "quantity": "4",
      "categoryName": "Diary",
    },
    {
      "productName": "Salmon",
      "quantity": "2",
      "categoryName": "Fish",
    },
    {
      "productName": "Apple",
      "quantity": "10",
      "categoryName": "Fruits",
    },
    {
      "productName": "Avocado",
      "quantity": "4",
      "categoryName": "Fruits",
    },
    {
      "productName": "Eggs",
      "quantity": "5",
      "categoryName": "Diary",
    },
    {
      "productName": "Yogurt",
      "quantity": "4",
      "categoryName": "Diary",
    },
    {
      "productName": "Salmon",
      "quantity": "2",
      "categoryName": "Fish",
    },
  ];

  @override
  void initState() {
    //Getting the list of products from the backend using the genericGet function
    Future.delayed(Duration.zero, () async {
      dynamic list = await genericGet('Product', ''); //to be edited
      setState(() {
        productsData = list;
      });
    });
    try {
      setState(() {
        stockName = Get.arguments['name'];
      });
    } catch (e) {}
    super.initState();
  }

  //Function for listing the products
  List<Widget> listProducts() {
    List<SingleListItem> items = [];
    for (var i = 0; i < 5; i++) {
      items.add(
        SingleListItem(
          deleteBtnFunctionality: () => print('delete'),
          editBtnFunctionlity: () => print('edit'),
          itemHeader: "Product name: " + "Apple",
          itemTitle: "Quantity: " + "3",
          itemSubTitle: "category: " + "Fruit",
        ),
      );
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
                        'List of your products in ' + stockName,
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
                    SizedBox(
                      height: getSh(context) / 50,
                    ),
                    //Products list
                    Container(
                      height: getSh(context) / 1.7,
                      child: SingleChildScrollView(
                        child: Column(
                          children: listProducts(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Add product button
            // Container(
            //   child: CustomButton(
            //     title: 'Add Product',
            //     // onTapCallBack: () {
            //     //   showDialog(
            //     //       context: context,
            //     //       builder: (BuildContext context) {
            //     //         return AlertDialog(
            //     //           content: Stack(
            //     //             clipBehavior: Clip.none,
            //     //             children: <Widget>[
            //     //               Positioned(
            //     //                 right: -40.0,
            //     //                 top: -40.0,
            //     //                 child: InkResponse(
            //     //                   onTap: () {
            //     //                     Navigator.of(context).pop();
            //     //                   },
            //     //                   child: CircleAvatar(
            //     //                     child: Icon(Icons.close),
            //     //                     backgroundColor: Colors.red,
            //     //                   ),
            //     //                 ),
            //     //               ),
            //     //               Form(
            //     //                 key: formKey,
            //     //                 child: Column(
            //     //                   mainAxisSize: MainAxisSize.min,
            //     //                   children: <Widget>[
            //     //                     Padding(
            //     //                       padding: EdgeInsets.all(8.0),
            //     //                       child: TextFormField(
            //     //                         enabled: true,
            //     //                         decoration: InputDecoration(
            //     //                           labelText: 'Product Name',
            //     //                           border: OutlineInputBorder(
            //     //                             borderRadius:
            //     //                                 BorderRadius.circular(10),
            //     //                           ),
            //     //                         ),
            //     //                         onChanged: (value) {
            //     //                           productNameController.text = value;
            //     //                         },
            //     //                       ),
            //     //                     ),
            //     //                     Padding(
            //     //                       padding: EdgeInsets.all(8.0),
            //     //                       child: TextFormField(
            //     //                         enabled: true,
            //     //                         decoration: InputDecoration(
            //     //                           labelText: 'Quantity',
            //     //                           border: OutlineInputBorder(
            //     //                             borderRadius:
            //     //                                 BorderRadius.circular(10),
            //     //                           ),
            //     //                         ),
            //     //                         onChanged: (value) {
            //     //                           productNameController.text = value;
            //     //                         },
            //     //                       ),
            //     //                     ),
            //     //                     ConstrainedBox(
            //     //                       constraints:
            //     //                           const BoxConstraints.tightFor(
            //     //                               width: 100.0),
            //     //                       child: _pickingType == FileType.custom
            //     //                           ? TextFormField(
            //     //                               maxLength: 15,
            //     //                               autovalidateMode:
            //     //                                   AutovalidateMode.always,
            //     //                               controller: extensionController,
            //     //                               decoration: InputDecoration(
            //     //                                 labelText: 'File extension',
            //     //                               ),
            //     //                               keyboardType: TextInputType.text,
            //     //                               textCapitalization:
            //     //                                   TextCapitalization.none,
            //     //                             )
            //     //                           : const SizedBox(),
            //     //                     ),
            //     //                     Padding(
            //     //                       padding: const EdgeInsets.only(
            //     //                           top: 50.0, bottom: 20.0),
            //     //                       child: Column(
            //     //                         children: <Widget>[
            //     //                           ElevatedButton(
            //     //                             onPressed: () => print('object'),
            //     //                             child: Text('Pick file'),
            //     //                           ),
            //     //                           SizedBox(height: 10),
            //     //                         ],
            //     //                       ),
            //     //                     ),
            //     //                     Padding(
            //     //                       padding: const EdgeInsets.all(8.0),
            //     //                       child: CustomButton(
            //     //                         title: "Submit",
            //     //                         onTapCallBack: () async {
            //     //                           if (formKey.currentState!
            //     //                               .validate()) {
            //     //                             formKey.currentState!.save();
            //     //                             var stock = Product(
            //     //                               id: 0,
            //     //                               name: productNameController.text
            //     //                                   .toString(),
            //     //                               category: 0,
            //     //                               imgUrl: "",
            //     //                             );
            //     //                           }
            //     //                         },
            //     //                       ),
            //     //                     )
            //     //                   ],
            //     //                 ),
            //     //               ),
            //     //             ],
            //     //           ),
            //     //         );
            //     //       });
            //     // },
            //   ),
            //   margin: EdgeInsets.only(
            //     right: getSw(context) / 10,
            //     top: getSh(context) / 30,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Container(
        child: Column(
          children: [CustomAppBar(), _StockProductsBody(context)],
        ),
      ),
    );
  }
}
