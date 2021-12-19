// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/controllers/LoginController.dart';
import 'package:snap_n_go/domain/controllers/StockController.dart';
import 'package:snap_n_go/domain/models/Stock.dart';
import 'package:snap_n_go/view/widgets/AppBar/Appbar.dart';
import 'package:snap_n_go/view/widgets/CardsList/CardsList.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

///This widget class is responsible of the ManageStock() content
///It has a menu and the body of the ManageStock()

class ManageStock extends StatefulWidget {
  @override
  State<ManageStock> createState() => _ManageStock();
}

class _ManageStock extends State<ManageStock> {
  //This variable is responsible of the Stock screen active button from the menu
  int whichBtn = 2;
  List<Stock> stocks = [];
  final stockController = Get.put(StockController());
  final loginController = Get.put(LoginController());
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var tmp;
    Future.delayed(Duration.zero, () async {
      // await genericGet('Stock', 'all');
      tmp = await stockController
          .getStocksByUserId(loginController.userInfo['id'])
          .forEach((i) {
        tmp.add(Stock.fromJson(i));
      });
    }).then((value) => {
          setState(() {
            stocks = tmp ?? [];
          })
        }).then((value) => print('stocks: $stocks'));
  }

  //This Function of type widget returns the whole body of the ManageStock
  Widget _ManageStockBody(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Container containing text and image
          Container(
            padding: EdgeInsets.only(
                left: getSw(context) / 21, right: getSw(context) / 21),
            // color: Colors.red,
            width: getSw(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back !',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getSh(context) / 50,
                ),
                CustomButton(
                  title: 'Add Warehouse',
                  onTapCallBack: () {
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, child) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                actions: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                controller: nameController,
                                                enabled: true,
                                                showCursor: true,
                                                textInputAction:
                                                    TextInputAction.done,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            child: TextFormField(
                                              controller: addressController,
                                              enabled: true,
                                              showCursor: true,
                                              textInputAction:
                                                  TextInputAction.done,
                                            ),
                                          )),
                                          CustomButton(
                                            title: 'Submit',
                                            onTapCallBack: () {
                                              var newStock = Stock(
                                                  name: nameController.text
                                                      .toString(),
                                                  address: addressController
                                                      .text
                                                      .toString(),
                                                  products: [],
                                                  stockProducts: []);
                                              stockController
                                                  .addStock(newStock);
                                              customAlert(
                                                  context,
                                                  'Success',
                                                  'Warehouse Successfully Created',
                                                  AlertType.success,
                                                  Colors.orange[300]);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 400),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: TextFormField(
                                        controller: nameController,
                                        enabled: true,
                                        showCursor: true,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: TextFormField(
                                      controller: addressController,
                                      enabled: true,
                                      showCursor: true,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  )),
                                  CustomButton(
                                    title: 'Submit',
                                    onTapCallBack: () {
                                      var newStock = Stock(
                                          name: nameController.text.toString(),
                                          address:
                                              addressController.text.toString(),
                                          products: [],
                                          stockProducts: []);
                                      stockController.addStock(newStock);
                                      customAlert(
                                          context,
                                          'Success',
                                          'Warehouse Successfully Created',
                                          AlertType.success,
                                          Colors.orange[300]);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
                SizedBox(
                  height: getSh(context) / 50,
                ),
                CardList(title: 'Available Warehouses', items: stocks)
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      backgroundColor: Colors.orange.shade50,
      body: ListView(
        children: [CustomAppBar(), 
        
        // _ManageStockBody(context)
        ],
      ),
    );
  }
}
