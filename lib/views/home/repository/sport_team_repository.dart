import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_team.dart';
import 'package:iwacai_lottery_app/views/base/model/team_census.dart';
import 'package:iwacai_lottery_app/views/base/model/team_witting.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';

class SportTeamRepository {
  ///
  /// 查询球队详情
  ///
  static Future<SportTeam> sportTeam(
      {required int teamId, required int leagueId}) {
    return HttpRequest()
        .get('/ssport/app/team/$leagueId/$teamId')
        .then((value) => SportTeam.fromJson(value.data));
  }

  ///
  /// 用户关注球队
  ///
  static Future<void> focusTeam(int teamId) {
    return HttpRequest()
        .post('/ssport/app/team/focus/$teamId')
        .then((value) => null);
  }

  ///
  /// 用户取消关注球队
  ///
  static Future<void> cancelFocus(int teamId) {
    return HttpRequest()
        .delete('/ssport/app/team/focus/$teamId')
        .then((value) => null);
  }

  ///
  /// 查询用户关注球队列表
  ///
  static Future<PageResult<FocusTeam>> focusTeamList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/app/team/focus/list', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (data) => FocusTeam.fromJson(data),
            ));
  }

  ///
  /// 查询赛季球队集合
  ///
  static Future<List<SportTeam>> seasonTeams(int seasonId) {
    return HttpRequest().get('/ssport/share/team/list/$seasonId').then((value) {
      List list = value.data;
      return list.map((e) => SportTeam.fromJson(e)).toList();
    });
  }

  ///
  /// 查询赛季球队数据统计信息
  ///
  static Future<TeamCensus?> teamCensus(
      {required int seasonId, required int teamId}) {
    return HttpRequest()
        .get('/ssport/share/team/census/$seasonId/$teamId')
        .then((value) =>
            value.data != null ? TeamCensus.fromJson(value.data) : null);
  }

  ///
  /// 球队最近比赛赛事
  ///
  static Future<List<SportMatch>> nearestMatches(int teamId) {
    return HttpRequest()
        .get('/ssport/share/team/$teamId/nearest')
        .then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 查询球队比赛情报信息
  static Future<PageResult<TeamMatchWitting>> teamMatchWittings(
      {required int teamId, int page = 1, int limit = 2}) {
    return HttpRequest().get('/ssport/share/team/witting/match',
        params: {'teamId': teamId, 'page': page, 'limit': limit}).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => TeamMatchWitting.fromJson(e),
      ),
    );
  }

  ///
  /// 分页查询球队情报信息
  ///
  static Future<PageResult<TeamWitting>> wittingList(
      {required int teamId, int page = 1, int limit = 10}) {
    return HttpRequest().get('/ssport/share/team/witting',
        params: {'teamId': teamId, 'page': page, 'limit': limit}).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => TeamWitting.fromJson(e),
      ),
    );
  }

  ///
  ///
  static Future<Map<int, TeamCensus>> matchTeamCensus(int matchId) {
    return HttpRequest()
        .get('/ssport/share/team/census/match/$matchId')
        .then((value) {
      Map<String, dynamic> result = value.data;
      return result
          .map((k, v) => MapEntry(int.parse(k), TeamCensus.fromJson(v)));
    });
  }

  ///
  /// 查询比赛球队
  static Future<Map<int, List<TeamWitting>>> matchTeamWitting(int matchId) {
    return HttpRequest()
        .get('/ssport/share/team/witting/match/$matchId')
        .then((value) {
      Map<String, dynamic> data = value.data;
      return data.map(
        (key, value) {
          List list = value;
          return MapEntry(
            int.parse(key),
            list.map((e) => TeamWitting.fromJson(e)).toList(),
          );
        },
      );
    });
  }
}
