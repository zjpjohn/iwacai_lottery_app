import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season_vo.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/season_info_repository.dart';

class LeagueDetailController extends BaseRequestController {
  ///联赛信息
  late LeagueInfo league;

  ///当前最新赛季
  LeagueSeasonVo? latestSeason;

  ///选择的轮次
  PickedSeasonRound? _round;

  ///赛季集合
  List<LeagueSeason> seasons = [];

  ///已选择的赛季
  LeagueSeason? _season;

  bool _showSeason = false;

  bool get showSeason => _showSeason;

  set showSeason(bool value) {
    _showSeason = value;
    update();
  }

  LeagueSeason? get season => _season;

  set season(LeagueSeason? season) {
    _season = season;
    if (season != null) {
      _checkRound();
      update();
    }
  }

  void focusAction() {
    if (league.focused == 0) {
      EasyLoading.show(status: '操作中');
      LeagueInfoRepository.focusLeague(league.id).then((value) {
        league.focused = 1;
        update();
      }).whenComplete(() {
        Future.delayed(
          const Duration(microseconds: 200),
          () => EasyLoading.dismiss(),
        );
      });
      return;
    }
    EasyLoading.show(status: '操作中');
    LeagueInfoRepository.cancelFocus(league.id).then((value) {
      league.focused = 0;
      update();
    }).whenComplete(() {
      Future.delayed(
        const Duration(microseconds: 200),
        () => EasyLoading.dismiss(),
      );
    });
  }

  void _checkRound() {
    ///
    if (latestSeason == null) {
      return;
    }

    ///历史赛季
    if (latestSeason!.seasonId > season!.id) {
      _round = PickedSeasonRound(
          leagueId: season!.leagueId,
          seasonId: season!.id,
          round: season!.maxRound,
          maxRound: season!.maxRound);
      return;
    }

    ///当前赛季
    String round = league.cup == 0
        ? latestSeason!.subRound!.currRound
        : latestSeason!.cupRound!.currRound.name;

    String maxRound = league.cup == 0 ? season!.maxRound : '';

    ///当前赛季
    _round = PickedSeasonRound(
        leagueId: latestSeason!.leagueId,
        seasonId: latestSeason!.seasonId,
        round: round,
        maxRound: maxRound);
  }

  PickedSeasonRound? get round => _round;

  @override
  Future<void> request() async {
    showLoading();
    int leagueId = int.parse(Get.parameters['leagueId']!);

    ///联赛信息
    Future<void> leagueFuture = LeagueInfoRepository.leagueInfo(leagueId)
        .then((value) => league = value);

    ///最新赛季信息
    Future<void> latestSeasonFuture =
        SeasonInfoRepository.latestSeason(leagueId)
            .then((value) => latestSeason = value);

    ///赛季集合
    Future<void> seasonFuture =
        LeagueInfoRepository.leagueSeasons(leagueId).then((value) {
      seasons
        ..clear()
        ..addAll(value);
    });

    Future.wait([leagueFuture, latestSeasonFuture, seasonFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (seasons.isNotEmpty) {
          season = seasons[0];
        }
        showSuccess(league);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

class PickedSeasonRound {
  ///联赛标识
  late int leagueId;

  ///赛季标识
  late int seasonId;

  ///当前轮次
  late String round;

  ///最大轮次
  late String maxRound;

  PickedSeasonRound({
    required this.leagueId,
    required this.seasonId,
    required this.round,
    required this.maxRound,
  });
}
