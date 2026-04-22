import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/team_census.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';
import 'package:iwacai_lottery_app/views/means/controller/season_refresh_controller.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_center_controller.dart';

class TeamMetricController extends BaseRequestController
    implements RefreshController {
  ///
  TeamCensus? census;
  int _type = 0;
  TeamStatVal? stats;

  int get type => _type;

  set type(int type) {
    if (_type == type) {
      return;
    }
    _type = type;
    switch (_type) {
      case 0:
        stats = census!.allData;
        break;
      case 1:
        stats = census!.homeData;
        break;
      case 2:
        stats = census!.awayData;
    }
    update();
  }

  @override
  Future<void> request() async {
    TeamCenterController teamController = Get.find<TeamCenterController>();

    if (teamController.season == null) {
      state = RequestState.empty;
      update();
      return;
    }

    showLoading();
    SportTeamRepository.teamCensus(
            seasonId: teamController.season!.id,
            teamId: int.parse(Get.parameters['teamId']!))
        .then((value) {
      census = value;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (census != null) {
          stats = census!.awayData;
        }
        showSuccess(census);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void onRefresh() {
    request();
  }
}
