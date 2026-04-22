import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season_vo.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/season_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';

class LeagueScheduleController extends BaseRequestController {
  ///已选中的赛季阶段
  LeagueSeasonSround? seriesStage;

  ///杯赛选中的赛季阶段
  LeagueSeasonCround? cupStage;

  ///
  late int _stageId;

  int get stageId => _stageId;

  ///
  late String _round;

  String get round => _round;

  ///
  LeagueSeasonVo? seasonVo;
  List<SportMatch> matches = [];

  ///
  /// 联赛赛季阶段选择
  void seriesStageTap(LeagueSeasonSround stage) {
    seriesStage = stage;
    _stageId = stage.stageId;
    update();
    if (seasonVo!.subRound!.currStage.stageId > stage.stageId) {
      seriesRound(seriesStage!.rounds!.last);
    } else if (seasonVo!.subRound!.currStage.stageId < stage.stageId) {
      seriesRound(seriesStage!.rounds!.first);
    } else {
      seriesRound(seasonVo!.subRound!.currRound);
    }
  }

  ///
  /// 上一阶段
  void last() {
    if (seasonVo!.cup == 0) {
      int index = seriesStage!.rounds!.indexWhere((e) => round == e);
      if (index == -1) {
        return;
      }
      seriesRound(seriesStage!.rounds![index - 1]);
      return;
    }
    int index =
        seasonVo!.cupRound!.stages.indexWhere((e) => stageId == e.stageId);
    if (index == -1) {
      return;
    }
    var cStage = seasonVo!.cupRound!.stages[index - 1];
    cupRound(cStage.stageId, cStage.name);
  }

  ///
  ///下一阶段
  void next() {
    if (seasonVo!.cup == 0) {
      int index = seriesStage!.rounds!.indexWhere((e) => round == e);
      if (index == -1 || index == seriesStage!.rounds!.length - 1) {
        return;
      }
      seriesRound(seriesStage!.rounds![index + 1]);
      return;
    }
    int index =
        seasonVo!.cupRound!.stages.indexWhere((e) => stageId == e.stageId);
    if (index == -1 || index == seasonVo!.cupRound!.stages.length - 1) {
      return;
    }
    var cStage = seasonVo!.cupRound!.stages[index - 1];

    cupRound(cStage.stageId, cStage.name);
  }

  ///
  /// 联赛轮次选择
  void seriesRound(String round) {
    _round = round;
    update();
    loadMatchSchedule();
  }

  ///
  /// 杯赛轮次选择
  void cupRound(int stageId, String round) {
    _stageId = stageId;
    _round = round;
    update();
    loadMatchSchedule();
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

    ///赛季信息
    await SeasonInfoRepository.leagueSeason(season.id).then((value) {
      seasonVo = value;
      if (seasonVo!.cup == 0) {
        _round = seasonVo!.subRound!.currRound;
        _stageId = seasonVo!.subRound!.currStage.stageId;
        seriesStage = seasonVo!.subRound!.currStage;
      } else {
        _round = seasonVo!.cupRound!.currRound.name;
        _stageId = seasonVo!.cupRound!.currRound.stageId;
        cupStage = seasonVo!.cupRound!.currRound;
      }
    }).catchError((error) {
      showError(error);
    });

    ///加载赛事赛程
    loadMatchSchedule();
  }

  void loadMatchSchedule() {
    if (seasonVo == null) {
      state = RequestState.empty;
      update();
      return;
    }
    showLoading();
    SportMatchRepository.seasonMatchSchedule(
            seasonId: seasonVo!.seasonId, stageId: stageId, round: round)
        .then((value) {
      matches
        ..clear()
        ..addAll(value);
      showSuccess(matches);
    }).catchError((error) {
      showError(error);
    });
  }
}
