import 'package:iwacai_lottery_app/views/base/model/team_census.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/match_index_model.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';

class MatchTeamCensusController extends BaseRequestController {
  ///
  final int matchId;

  MatchTeamCensusController(this.matchId);

  ///
  /// 主客队进球指数
  late PointGoalIndex goalIndex;

  ///比赛胜负指数
  late WinLossIndex wolIndex;

  ///主队统计数据
  TeamCensus? homeCensus;

  ///客队统计数据
  TeamCensus? awayCensus;

  Future<void> requestFuture() async {
    Future<void> indexAsync = SportMatchRepository.pointGoalIndex(matchId)
        .then((value) => goalIndex = value);
    Future<void> wolAsync = SportMatchRepository.wolIndex(matchId)
        .then((value) => wolIndex = value);
    Future<void> censusAsync =
        SportTeamRepository.matchTeamCensus(matchId).then((value) {
      homeCensus = value[1];
      awayCensus = value[0];
    });
    Future.wait([indexAsync, wolAsync, censusAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> request() async {
    await requestFuture();
  }
}
