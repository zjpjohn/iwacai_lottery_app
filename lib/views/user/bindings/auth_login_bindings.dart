import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/auth_login_controller.dart';

class AuthLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLoginController());
  }
}
