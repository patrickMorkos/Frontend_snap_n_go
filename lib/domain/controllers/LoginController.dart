import 'package:get/get.dart';
import 'package:snap_n_go/domain/entities/LoggedUser.dart';

class LoginController extends GetxController {
  dynamic userInfo = {}.obs;

  void setCurrentUserInfo(LoggedUser user) {
    userInfo = user.toJson();
  }
  
  
}
