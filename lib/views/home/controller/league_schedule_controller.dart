import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';

class LeagueScheduleController extends BasePageQueryController {
  ///
  ///
  late int leagueId;

  late LeagueSchedule schedule;

  @override
  Future<void> onInitial() async {
    leagueId = int.parse(Get.parameters['leagueId']!);
    showLoading();
    LeagueInfoRepository.matchSchedule(leagueId).then((value) {
      schedule = value;
      Future.delayed(const Duration(milliseconds: 200), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {
    LeagueInfoRepository.matchSchedule(leagueId).then((value) {
      schedule = value;
      state = RequestState.success;
      update();
    }).catchError((error) {
      showError(error);
    });
  }
}
