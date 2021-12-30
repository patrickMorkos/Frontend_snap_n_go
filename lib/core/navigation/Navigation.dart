import 'package:get/get.dart';
import 'package:snap_n_go/view/screens/AddNewProductScreen.dart';
import 'package:snap_n_go/view/screens/HomeScreen.dart';
import 'package:snap_n_go/view/screens/LoginScreen.dart';
import 'package:snap_n_go/view/screens/ManageStockScreen.dart';
import 'package:snap_n_go/view/screens/RegisterScreen.dart';
import 'package:snap_n_go/view/screens/ScanScreen.dart';
import 'package:snap_n_go/view/screens/StockProduct.dart';

class Navigation {
  // Screen Routes List
  List<GetPage<dynamic>> routes = [
    // Main route and Home Page
    GetPage(name: '/', page: () => HomeScreen()),
    //Login screen route
    GetPage(name: '/Login', page: () => LoginScreen()),
    //Register screen route
    GetPage(name: '/Register', page: () => RegisterScreen()),
    //Scan screen route
    GetPage(name: '/Scan', page: () => ScanScreen()),
    //ManageStock screen route
    GetPage(name: '/ManageStock', page: () => ManageStock()),
    //StockProducts screen route
    GetPage(name: '/Products', page: () => StockProducts()),
    //AddNewProduct screen route
    GetPage(name: '/AddProduct', page: ()=>AddNewProduct())
  ];

  List<GetPage<dynamic>> getNavigationList() {
    return this.routes;
  }
}
