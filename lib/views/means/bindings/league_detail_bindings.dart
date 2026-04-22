import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';

class LeagueDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeagueDetailController());
  }
}
