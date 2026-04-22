import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';

class CountryLeagueController extends BaseRequestController {
  ///
  ///
  List<LeagueInfo> leagues = [];

  @override
  Future<void> request() async {
    showLoading();
    LeagueInfoRepository.countryLeagues(int.parse(Get.parameters['countryId']!))
        .then((value) {
      leagues
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(leagues);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
