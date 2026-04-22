import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/about_account_controller.dart';

class AboutAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutAccountController());
  }
}
