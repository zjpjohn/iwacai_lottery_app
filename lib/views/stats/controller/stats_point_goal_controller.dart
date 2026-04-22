import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_stats.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_stats_repository.dart';

class StatsPointGoalController extends BaseRequestController {
  ///
  int _type = 1;
  List<StatsInfo<PointGoalStats>> stats = [];

  int get type => _type;

  set type(int value) {
    _type = value;
    update();
    request();
  }

  @override
  Future<void> request() async {
    showLoading();
    LeagueStatsRepository.pointGoalStats(
      seasonId: int.parse(Get.parameters['seasonId']!),
      type: type,
    ).then((value) {
      stats
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(stats);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
