import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/help/controller.dart';

class AppHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppAssistantController());
  }
}
