import 'package:get/get.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/entities/LoggedUser.dart';

class OpenFoodController extends GetxController {
  dynamic productInformation = {}.obs;
  dynamic barcode = 'Unknown barcode'.obs;
  var isReady = false.obs;
  var scanMode = false.obs;
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

  void toggleScanMode() {
    if (scanMode.value == false) {
      scanMode.value = true;
    } else {
      scanMode.value = false;
      print('ready switched to ${scanMode.value}');
    }
  }

  void setProductInfo(dynamic info) {
    productInformation = info;
    print('Product info: $productInformation');
  }

  dynamic getProductInfoByBarcode() async {
    var response = await getProduct('code', barcode);
    print('response---> $response');
    // var count = int.parse(response['count']??'0');
    var count = response['count'];
    // print(count.runtimeType);
    if (count != 0) {
      toggleReady();
      List products = response['products'];
      print('found products-> $products');
      if(products.length>0) setProductInfo(products[0]);
    } else {
      print('No product found');
    }
    // toggleReady();
    // print(products.length);
    // print('only 1 ${products[0]}');
    //to access product name--> product_name
    //to access product nutriments--> nutriments
  }

  dynamic getProductInfoByName(String productName) async {
    var response = await getProduct('product_name', productName);
    // print('response---> $response');
    toggleReady();
    List products = response['products'];
    print('found match-> $products');
    print(products[0]);
    if (products.length > 0) setProductInfo(products[0]);
  }

  void addNewProduct(code, name) async {
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
