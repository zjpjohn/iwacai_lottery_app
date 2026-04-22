import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/feedback/controller.dart';

class AppFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppFeedbackController());
  }
}
