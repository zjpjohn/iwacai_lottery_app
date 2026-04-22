import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/kefu_contact_controller.dart';

class KefuContactBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KefuContactController());
  }
}
