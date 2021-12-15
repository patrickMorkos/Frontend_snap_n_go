import 'package:get/get.dart';
import 'package:snap_n_go/domain/entities/LogedUser.dart';

class LoginController extends GetxController {
  dynamic userInfo = {}.obs;

  void setCurrentUserInfo(LogedUser user) {
    userInfo = user.toJson();
  }
}
