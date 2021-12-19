// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/domain/controllers/OpenFoodController.dart';
import 'package:snap_n_go/view/widgets/BarcodeScanner/barcodeScanner.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';

///This widget class is responsible of the ScanScreen() content
///It has a menu and the body of the ScanScreen()

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  //This variable is responsible of the Scan screen active button from the menu
  int whichBtn = 1;
  final foodController = Get.put(OpenFoodController());

  getFoodNutriments() {
    var nutriments = foodController.productInformation!['nutriments'];
    // print('nutriments--> $nutriments');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Protein: ${foodController.productInformation!['nutriments']!['proteins']} g',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text(
          'Fat: ${foodController.productInformation!['nutriments']!['fat']} g',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text(
          'Carbohydrate: ${foodController.productInformation!['nutriments']!['carbohydrates']} g',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text(
          'Bicarbonates: ${foodController.productInformation!['nutriments']!['bicarbonates']} g',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text(
          'Calcium: ${foodController.productInformation!['nutriments']!['calcium']} g',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text(
          'Calories: ${foodController.productInformation!['nutriments']!['energy-kcal']} g',
          style: TextStyle(color: Colors.grey[400]),
        ),
        Text(
          'Expiry Date: ${foodController.productInformation!['expiration_date']}',
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }





  Widget _ProductCard(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print('ready?? ${foodController.isReady.value}');
    return Obx(() => foodController.scanMode.isTrue
        ? (foodController.isReady.isTrue &&
                foodController.productInformation['product_name'] != null)
            ? Container(
                margin: EdgeInsets.only(top: 0.1 * height),
                child: Card(
                  child: Container(
                    height: 0.5 * height,
                    width: 0.8 * width,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 0.02 * height),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(foodController
                                        .productInformation['product_name'] ??
                                    ''),
                                CloseButton(
                                  onPressed: () {
                                    foodController.toggleScanMode();
                                  },
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 0.03 * height),
                          height: 0.2 * height,
                          // width: 0.3*width,
                          child: Image.network(foodController
                                  .productInformation!['selected_images']![
                              'front']!['display']!['fr'],fit: BoxFit.cover,errorBuilder: (context,Object,StackTrace){
                                return Text('Unable to load Image');
                              },),
                        ),
                        Container(
                          // margin:EdgeInsets.only(top:0.2*height),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              foodController
                                          .productInformation['product_name'] !=
                                      null
                                  ? getFoodNutriments()
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.all(10),
                ),
              )
            : Center(
                child: Container(
                  margin: EdgeInsets.only(top: height * 0.1),
                  child: Text('No Food Item Found !'),
                ),
              )
        : Container(
            margin: EdgeInsets.only(top: 0.1 * height),
            child: Text('Press On Scan Barcode To Start Scanning',
                style: TextStyle(fontWeight: FontWeight.bold))));
    // return foodController.isReady.isTrue?
  }

  //This Function of type widget returns the whole body of the ScanScreen
  Widget _ScanBody(BuildContext context) {
    dynamic width = MediaQuery.of(context).size.width;
    dynamic height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Container containing text and image
        Container(
          padding: EdgeInsets.only(
              left: getSw(context) / 21, right: getSw(context) / 21),
          // color: Colors.red,
          width: getSw(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: width * 0.2),
                        child: Barcode()),
                    _ProductCard(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: ListView(
        children: [
          Menu(
            isActive: whichBtn,
          ),
          _ScanBody(context)
        ],
      ),
    );
  }
}
