import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_search_controller.dart';

class LeagueSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeagueSearchController>(() => LeagueSearchController());
  }
}
