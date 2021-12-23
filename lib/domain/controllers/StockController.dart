import 'package:get/get.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/entities/LoggedUser.dart';
import 'package:snap_n_go/domain/models/Product.dart';
import 'package:snap_n_go/domain/models/Stock.dart';

class StockController extends GetxController {
  List<dynamic> stocks = [].obs;
  var name = ''.obs;
  var address = ''.obs;

  void setName(String name) {
    this.name.value = name;
  }

  String getName() {
    return this.name.value;
  }

  void setAddress(String address) {
    this.address.value = address;
  }

  String getAddress() {
    return this.address.value;
  }

  getStocksByUserId(dynamic userId) async {
    // dynamic res = await genericGet("Stock", "/user/$userId");
    dynamic res = await genericGet("Stock", "user/3");
    // print('data $res');
    if (res.length == 0) stocks = [];
    for (var item in res) {
      stocks.add(item);
    }
    print("Successfully imported stocks from backend..");
  }

  addStock(Stock? stock) async {
    if (stock != null) {
      dynamic res = await genericPost('Stock', stock);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return "Successfully added stock to backend..";
      } else
        return 'Unable to add stock to backend..';
    }
  }

  removeStock(int idStock) async {
    dynamic res = await genericDelete('Stock', idStock);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return 1;
    } else {
      return 0;
    }
  }
}
