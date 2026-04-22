import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
