import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/draw_voucher_controller.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_voucher_controller.dart';

class UserVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserVoucherController());
  }
}

class DrawVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawVoucherController>(() => DrawVoucherController());
  }
}
