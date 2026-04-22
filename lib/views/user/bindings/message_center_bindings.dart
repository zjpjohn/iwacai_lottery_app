import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/channel_message_controller.dart';
import 'package:iwacai_lottery_app/views/user/controller/message_center_controller.dart';

class MessageCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageCenterController());
  }
}

class ChannelMessageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChannelMessageController());
  }
}
