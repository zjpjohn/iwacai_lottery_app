import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_sign_controller.dart';

class UserSignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSignController());
  }
}
