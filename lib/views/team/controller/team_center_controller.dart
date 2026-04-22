import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_team.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/season_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';

class TeamCenterController extends BaseRequestController {
  ///
  late SportTeam team;
  LeagueSeason? _season;
  List<LeagueSeason> seasons = [];

  bool _showSeason = false;

  bool get showSeason => _showSeason;

  void focusAction() {
    if (team.focused == 0) {
      EasyLoading.show(status: '操作中');
      SportTeamRepository.focusTeam(team.id).then((value) {
        team.focused = 1;
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
    SportTeamRepository.cancelFocus(team.id).then((value) {
      team.focused = 0;
      update();
    }).whenComplete(() {
      Future.delayed(
        const Duration(microseconds: 200),
        () => EasyLoading.dismiss(),
      );
    });
  }

  set showSeason(bool value) {
    _showSeason = value;
    update();
  }

  LeagueSeason? get season => _season;

  set season(LeagueSeason? season) {
    _season = season;
    if (season != null) {
      update();
    }
  }

  @override
  Future<void> request() async {
    showLoading();
    int teamId = int.parse(Get.parameters['teamId']!);
    int leagueId = int.parse(Get.parameters['leagueId']!);

    ///
    Future<void> teamFuture =
        SportTeamRepository.sportTeam(teamId: teamId, leagueId: leagueId)
            .then((value) => team = value);
    Future<void> seasonFuture =
        SeasonInfoRepository.leagueSeasons(leagueId).then((value) {
      seasons
        ..clear()
        ..addAll(value);
    });

    ///
    Future.wait([teamFuture, seasonFuture]).then((value) {
      if (seasons.isNotEmpty) {
        _season = seasons[0];
      }
      showSuccess(team);
    }).catchError((error) {
      showError(error);
    });
  }
}
