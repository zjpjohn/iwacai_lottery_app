import 'package:get/get.dart';
import 'package:iwacai_lottery_app/app/controller.dart';
import 'package:iwacai_lottery_app/views/main/controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.put<AppController>(AppController());
  }
}
