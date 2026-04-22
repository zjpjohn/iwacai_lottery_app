import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/season_info_repository.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';
import 'package:iwacai_lottery_app/views/means/controller/season_refresh_controller.dart';

class LeagueRankController extends BaseRequestController
    implements RefreshController {
  ///积分排名类型
  int _type = 1;
  List<LeagueTeamScore> scores = [];

  int get type => _type;

  set type(int value) {
    if (_type == value) {
      return;
    }
    _type = value;
    update();
    request();
  }

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
    SeasonInfoRepository.teamScores(seasonId: season.id, type: type)
        .then((value) {
      scores
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(scores);
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
