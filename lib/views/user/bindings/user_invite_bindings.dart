import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/invite_history_controller.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_invite_controller.dart';

class UserInviteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserInviteController>(() => UserInviteController());
  }
}

class InviteHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteHistoryController());
  }
}
