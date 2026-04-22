import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_rights_controller.dart';

class UserRightsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserRightsController());
  }
}
