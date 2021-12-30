// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/domain/controllers/OpenFoodController.dart';
import 'package:snap_n_go/view/widgets/BarcodeScanner/barcodeScanner.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';
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
  String dropdownValue = 'Barcode';

  final foodController = Get.put(OpenFoodController());
  final searchController = TextEditingController();
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
    print('info: ${foodController.productInformation['product_name']}');
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
                          child: Image.network(
                            foodController.productInformation![
                                'selected_images']!['front']!['display']!['fr'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, Object, StackTrace) {
                              return Text('Unable to load Image');
                            },
                          ),
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
            child: isMobileDevice()
                ? Text('Press On Scan Barcode To Start Scanning',
                    style: TextStyle(fontWeight: FontWeight.bold))
                : Container()));
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isMobileDevice()
                            ? Container(
                                margin: EdgeInsets.only(left: width * 0.2),
                                child: Barcode())
                            : Container(
                                height: 50,
                                width: getSw(context) * 0.6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    )
                                    // color: Colors.white,
                                    ),
                                child: TextField(
                                  // decoration: InputDecoration(),
                                  controller: searchController,
                                  cursorColor: Colors.orange,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.length > 3) {
                                      foodController.setBarcode(value);
                                    }
                                  },
                                ),
                              ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          items: <String>['Barcode', 'Product Name']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: getSh(context) / 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: CustomButton(
                        title: 'Search Product',
                        onTapCallBack: () async {
                          print('searching for product..');
                          // await scanBarcode();
                          // foodController.setBarcode('8024884500403');
                          switch (dropdownValue) {
                            case 'Barcode':
                              foodController.setBarcode(
                                  searchController.text.trim().toString());
                              await foodController.getProductInfoByBarcode();
                              break;
                            case 'Product Name':
                              searchController.text.trim().toString();
                              await foodController.getProductInfoByName(
                                  searchController.text
                                      .trim()
                                      .toLowerCase()
                                      .toString());
                              break;
                            default:
                          }
                          foodController.toggleScanMode();
                          if (foodController
                                  .productInformation['product_name'] ==
                              null) {
                            customAlert(context, 'Error', 'Product Not Found !',
                                AlertType.error, Colors.red);
                          } else {
                            customAlert(context, 'Success', 'Product Found !',
                                AlertType.success, Colors.green);
                          }
                        },
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 10.0),
                    //   child: TextField(
                    //     onChanged: (value) {
                    //       if (value.length >= 3) {
                    //         Future.delayed(Duration(milliseconds: 3000),
                    //             () async {
                    //           await foodController.getProductInfoByName(value);
                    //         });
                    //       }
                    //     },
                    //   ),
                    // ),
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
        children: [Menu(isActive: whichBtn), _ScanBody(context)],
      ),
    );
  }
}
