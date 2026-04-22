import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_team.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';
import 'package:iwacai_lottery_app/views/means/controller/season_refresh_controller.dart';

class LeagueTeamController extends BaseRequestController
    implements RefreshController {
  ///
  List<SportTeam> teams = [];

  @override
  Future<void> request() async {
    showLoading();
    LeagueDetailController leagueController =
        Get.find<LeagueDetailController>();
    LeagueSeason? season = leagueController.season;
    if (season == null) {
      showSuccess(null);
      return;
    }
    SportTeamRepository.seasonTeams(season.id).then((value) {
      teams
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(teams);
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
