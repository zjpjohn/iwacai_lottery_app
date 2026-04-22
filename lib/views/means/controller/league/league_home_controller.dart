import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/feature_league.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_stats_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/season_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';

const Map<int, String> featureTypes = {1: '胜负', 2: '进球'};

class LeagueHomeController extends BaseRequestController {
  ///
  List<SportMatch> matches = [];
  List<LeagueTeamScore> scores = [];

  FeatureWinLose? winLose;
  FeatureBigSmall? bigSmall;
  int _type = 1;

  int get type => _type;

  set type(int value) {
    _type = value;
    update();
    loadFeature();
  }

  void recoverValue() {
    winLose = null;
    bigSmall = null;
    _type = 1;
  }

  void loadFeature() {
    LeagueDetailController controller = Get.find<LeagueDetailController>();
    LeagueSeason? season = controller.season;
    if (season == null) {
      return;
    }
    switch (type) {
      case 1:
        if (winLose != null) {
          return;
        }
        EasyLoading.show(status: '加载中');
        LeagueStatsRepository.featureWinLose(season.id).then((value) {
          winLose = value;
          Future.delayed(const Duration(milliseconds: 300), () {
            EasyLoading.dismiss();
            update();
          });
        }).catchError((error) {
          EasyLoading.showError('加载失败');
        });
        break;
      case 2:
        if (bigSmall != null) {
          return;
        }
        EasyLoading.show(status: '加载中');
        LeagueStatsRepository.featureBigSmall(season.id).then((value) {
          bigSmall = value;
          Future.delayed(const Duration(milliseconds: 300), () {
            EasyLoading.dismiss();
            update();
          });
        }).catchError((error) {
          EasyLoading.showError('加载失败');
        });
        break;
    }
  }

  @override
  Future<void> request() async {
    ///恢复默认值
    recoverValue();

    ///
    LeagueDetailController controller = Get.find<LeagueDetailController>();
    LeagueSeason? season = controller.season;
    if (season == null) {
      showSuccess(true);
      return;
    }

    ///
    Future<void> matchFuture =
        SportMatchRepository.nearestMatches(season.id).then((value) {
      matches
        ..clear()
        ..addAll(value);
    });

    ///
    Future<void> scoreFuture =
        SeasonInfoRepository.seasonScores(season.id).then((value) {
      scores
        ..clear()
        ..addAll(value);
    });

    ///
    Future<void> winLoseFuture =
        LeagueStatsRepository.featureWinLose(season.id).then((value) {
      winLose = value;
    });

    ///
    showLoading();
    Future.wait([matchFuture, scoreFuture, winLoseFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
