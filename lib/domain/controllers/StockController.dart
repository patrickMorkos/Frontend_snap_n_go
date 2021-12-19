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
    dynamic res = await genericGet("Address", "/user/$userId");
    List data = res;
    if (data.length == 0) stocks = [];
    for (var item in data) {
      stocks.add(item);
    }
    print("Successfully imported stocks from backend..");
  }

  addStock(Stock? stock) {
    if (stock != null) {
      stocks.add(stock);
      print('Warehouse successfully added..');
    }
  }
}
