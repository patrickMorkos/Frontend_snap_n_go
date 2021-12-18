import 'package:get/get.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/entities/LogedUser.dart';

class OpenFoodController extends GetxController {
  dynamic productInformation = {}.obs;
  dynamic barcode = 'Unknown barcode'.obs;
  var isReady = false.obs;
  var scanMode=false.obs;
  void setBarcode(String code) {
    barcode = code;
    print('Detected barcode: $barcode');
  }

  String getBarcode() {
    return barcode;
  }

  void toggleReady() {
    if (isReady.value == false) {
      isReady.value = true;
    } else
      isReady.value == false;
      print('ready switched to ${isReady.value}');
  }

  void toggleScanMode(){
        if (scanMode.value == false) {
      scanMode.value = true;
    } else
      scanMode.value == false;
      print('ready switched to ${scanMode.value}');
  }

  void setProductInfo(dynamic info) {
    productInformation = info;
  }

  dynamic getProductInfoByBarcode() async{
    var response = await getProduct('code', barcode);
      print('response---> $response');
      toggleReady();
      List products=response['products'];
      print('found match-> $products');
      if(products.length >0)
      setProductInfo(products[0]);
      //to access product name--> product_name
      //to access product nutriments--> nutriments
  }

  dynamic getProductInfoByName(String productName) {
    var product = getProduct('product_name', productName);
    if (product != null) {
      return product;
    } else {
      print('No Product Found.');
    }
  }
  void addNewProduct(code,name) async {
  // define the product to be added.
  // more attributes available ...
  Product myProduct = Product(
    barcode: code,
    productName: name,
  );
  // query the OpenFoodFacts API
  Status result = await OpenFoodAPIClient.saveProduct(myUser, myProduct);

  if (result.status != 1) {
    throw Exception('Product could not be added: ${result.error}');
  }
}
}
