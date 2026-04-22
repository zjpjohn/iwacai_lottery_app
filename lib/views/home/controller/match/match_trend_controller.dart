import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/match_team_stats.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';

///
///
class MatchTrendController extends BaseRequestController {
  ///
  ///
  final int matchId;

  MatchTrendController(this.matchId);

  ///主队统计
  late MatchTeamStats homeStats;

  ///客队统计
  late MatchTeamStats awayStats;

  ///历史交锋
  List<SportMatch> historyBattles = [];
  BattleResult battleResult = BattleResult();

  @override
  Future<void> request() async {
    Future<void> statsFuture =
        SportMatchRepository.matchTeamStats(matchId).then((value) {
      homeStats = value['home']!;
      awayStats = value['away']!;
    });
    Future<void> battlesFuture =
        SportMatchRepository.historyBattles(matchId).then((value) {
      historyBattles = value;
    });
    Future.wait([statsFuture, battlesFuture]).then((_) {
      battleResult.calcMatches(historyBattles, homeStats.teamId);
      showSuccess(true);
    }).catchError((error) {
      showError(error);
    });
  }
}
