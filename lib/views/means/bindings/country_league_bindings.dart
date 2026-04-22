import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/means/controller/country_league_controller.dart';

class CountryLeagueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryLeagueController());
  }
}
