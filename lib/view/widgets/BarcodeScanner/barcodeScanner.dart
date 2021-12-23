import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:snap_n_go/domain/controllers/BarcodeController.dart';
import 'package:snap_n_go/domain/controllers/OpenFoodController.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';

class Barcode extends StatefulWidget {
  const Barcode({Key? key}) : super(key: key);

  @override
  _BarcodeState createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  final foodController = Get.put(OpenFoodController());
  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    foodController.setBarcode(barcodeScanRes);
    // foodController.setBarcode('8024884500403');
    await foodController.getProductInfoByBarcode();
  }

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  customAlert(context, title, desc, type, animationType, textColor) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: true,
        isOverlayTapDismiss: true,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: textColor,
        ),
        // constraints: BoxConstraints.expand(width: 300),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.topCenter);
    Alert(
      context: context,
      type: type,
      style: alertStyle,
      title: title,
      desc: desc,
      alertAnimation: fadeAlertAnimation,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomButton(
        title: 'Scan Barcode',
        onTapCallBack: () async {
          print('scanning barcode..');
          await scanBarcode();
          await foodController.getProductInfoByBarcode();
          foodController.toggleScanMode();
          if (foodController.productInformation['product_name'] == null) {
            customAlert(context, 'Error', 'Product Not Found !',
                AlertType.error, AnimationType.fromTop, Colors.red);
          } else {
            customAlert(context, 'Success', 'Product Found !',
                AlertType.success, AnimationType.fromTop, Colors.green);
          }
        },
      ),
    );
  }
}
