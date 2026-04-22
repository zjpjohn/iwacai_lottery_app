import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_center_controller.dart';

class TeamCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeamCenterController());
  }
}
