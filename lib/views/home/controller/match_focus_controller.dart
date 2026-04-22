import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/match_focus_league.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';

class MatchFocusController extends BasePageQueryController {
  ///
  FocusMatchQuery query = FocusMatchQuery();

  ///
  int total = 0;
  List<SportMatch> matches = [];

  ///
  List<MatchFocusLeague> leagues = [];

  ///
  ///
  set leagueId(int leagueId) {
    if (leagueId == query.leagueId) {
      query.leagueId = null;
    } else {
      query.leagueId = leagueId;
    }
    refreshController.callRefresh();
  }

  ///
  /// 取消订阅
  void cancelFocus(SportMatch match) {
    SportMatchRepository.cancelFocus(match.matchId).then((value) {
      total = total - 1;
      matches.removeWhere((e) => e.matchId == match.matchId);
      _modifyLeague(match);
      update();
      if (matches.isEmpty) {
        initialLoad(true);
      }
    }).catchError((error) {
      EasyLoading.showError('取消订阅失败');
    });
  }

  void _modifyLeague(SportMatch match) {
    MatchFocusLeague league =
        leagues.firstWhere((e) => e.leagueId == match.leagueId);
    league.matches = league.matches - 1;
    if (league.matches != 0) {
      return;
    }
    leagues.removeWhere((e) => e.leagueId == league.leagueId);
    if (league.leagueId == query.leagueId) {
      query.leagueId = null;
    }
  }

  void initialLoad(bool showLoad) async {
    if (showLoad) {
      showLoading();
    }
    query.page = 1;
    Future<void> leagueFuture =
        SportMatchRepository.matchFocusLeagues().then((value) {
      leagues
        ..clear()
        ..addAll(value);
      update();
    });
    Future<void> matchFuture =
        SportMatchRepository.focusMatchList(query.toJson()).then((value) {
      total = value.total;
      matches
        ..clear()
        ..addAll(value.records);
    });

    await Future.wait([leagueFuture, matchFuture]).then((values) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(matches);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onInitial() async {
    initialLoad(true);
  }

  @override
  Future<void> onLoadMore() async {
    if (total == matches.length) {
      EasyLoading.showToast('没有更多赛事');
      return;
    }
    query.page++;
    await SportMatchRepository.focusMatchList(query.toJson()).then((value) {
      total = value.total;
      matches.addAll(value.records);
      update();
    }).catchError((error) {
      query.page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    initialLoad(false);
  }

}

class FocusMatchQuery {
  ///
  int? leagueId;

  ///
  int page;

  ///
  int limit;

  FocusMatchQuery({this.leagueId, this.page = 1, this.limit = 10});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['leagueId'] = leagueId;
    json['page'] = page;
    json['limit'] = limit;
    return json;
  }
}
