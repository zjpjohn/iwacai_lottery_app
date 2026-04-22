import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/match_census.dart';
import 'package:iwacai_lottery_app/views/base/model/match_event.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/home/model/match_focus_league.dart';
import 'package:iwacai_lottery_app/views/home/model/match_index_model.dart';
import 'package:iwacai_lottery_app/views/home/model/match_team_stats.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';

///
///
class SportMatchRepository {
  ///
  /// 查询比赛日历
  ///
  static Future<List<SportMatch>> calendarMatches(DateTime dateTime) {
    return HttpRequest().get('/ssport/app/match/calendar', params: {
      'date': DateUtil.formatDate(dateTime, format: "yyyy-MM-dd")
    }).then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 查询联赛比赛日历
  ///
  static Future<List<SportMatch>> leagueDateMatches(
      {required int leagueId, required DateTime dateTime}) {
    return HttpRequest().get('/ssport/app/match/$leagueId/calendar', params: {
      'date': DateUtil.formatDate(dateTime, format: 'yyyy-MM-dd')
    }).then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 分页查询赛程列表
  ///
  static Future<PageResult<SportMatch>> dateMatches(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/app/match/list', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (e) => SportMatch.fromJson(e),
            ));
  }

  ///
  /// 分页查询赛程数据
  ///
  static Future<PageResult<SportMatch>> getDateSportMatches(
      Map<String, dynamic> params) {
    return HttpRequest().get('/ssport/app/match/list', params: params).then(
      (value) {
        return PageResult.fromJson(
          json: value.data,
          handle: (data) => SportMatch.fromJson(data),
        );
      },
    );
  }

  ///
  /// 查询赛季赛程
  ///
  static Future<List<SportMatch>> seasonMatchSchedule({
    required int seasonId,
    required int stageId,
    required String round,
  }) {
    return HttpRequest().get(
      '/ssport/share/match/season/schedule',
      params: {'seasonId': seasonId, 'stageId': stageId, 'round': round},
    ).then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 分页查询球队赛事
  ///
  static Future<PageResult<SportMatch>> teamMatches(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get(
          '/ssport/share/match/team/list',
          params: params,
        )
        .then(
          (value) => PageResult.fromJson(
            json: value.data,
            handle: (e) => SportMatch.fromJson(e),
          ),
        );
  }

  ///
  /// 查询比赛详情
  ///
  static Future<SportMatch> matchDetail(int matchId) {
    return HttpRequest()
        .get('/ssport/app/match/$matchId')
        .then((value) => SportMatch.fromJson(value.data));
  }

  ///
  /// 订阅专家
  static Future<void> focusMatch(int matchId) {
    return HttpRequest()
        .post('/ssport/app/match/focus/$matchId')
        .then((value) => null);
  }

  ///
  /// 取消订阅专家
  static Future<void> cancelFocus(int matchId) {
    return HttpRequest()
        .delete('/ssport/app/match/focus/$matchId')
        .then((value) => null);
  }

  ///
  /// 查询订阅赛事集合
  static Future<PageResult<SportMatch>> focusMatchList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/app/match/focus/list', params: params)
        .then(
          (value) => PageResult.fromJson(
            json: value.data,
            handle: (e) => SportMatch.fromJson(e),
          ),
        );
  }

  ///
  /// 查询订阅赛事联赛信息
  static Future<List<MatchFocusLeague>> matchFocusLeagues() {
    return HttpRequest().get('/ssport/app/match/focus/leagues').then((value) {
      List list = value.data;
      return list.map((e) => MatchFocusLeague.fromJson(e)).toList();
    });
  }

  ///
  /// 比赛事件集合
  static Future<List<MatchEvent>> matchEvents(int matchId) {
    return HttpRequest()
        .get('/ssport/share/match/events/$matchId')
        .then((value) {
      List list = value.data;
      return list
          .map((e) => MatchEvent.fromJson(e))
          .where((e) => e.type.value != 0)
          .toList();
    });
  }

  ///
  /// 比赛进球射门角球统计信息
  static Future<MatchCensus?> matchCensus(int matchId) {
    return HttpRequest().get('/ssport/share/match/census/$matchId').then(
      (value) {
        if (value.data != null) {
          return MatchCensus.fromJson(value.data);
        }
        return MatchCensus.empty();
      },
    );
  }

  ///
  ///  最近赛事
  static Future<List<SportMatch>> nearestMatches(int seasonId) {
    return HttpRequest()
        .get('/ssport/app/match/nearest/$seasonId')
        .then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 联赛今日热门比赛
  ///
  static Future<List<SportMatch>> leagueHotMatches(int leagueId) {
    return HttpRequest().get('/ssport/app/match/league/hot',
        params: {'leagueId': leagueId}).then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 今日全部热门比赛
  ///
  static Future<List<SportMatch>> hotMatches(Map<String, dynamic>? params) {
    return HttpRequest()
        .get('/ssport/app/match/hot', params: params)
        .then((value) {
      List list = value.data;
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 赛事球队统计数据
  ///
  static Future<Map<String, MatchTeamStats>> matchTeamStats(int matchId) {
    return HttpRequest().get('/ssport/app/match/team/stats',
        params: {'matchId': matchId}).then((value) {
      Map<String, dynamic> result = value.data;
      return {
        'home': MatchTeamStats.fromJson(result['home']),
        'away': MatchTeamStats.fromJson(result['away']),
      };
    });
  }

  ///
  /// 比赛球队历史交锋
  ///
  static Future<List<SportMatch>> historyBattles(int matchId) {
    return HttpRequest().get('/ssport/app/match/team/battle',
        params: {'matchId': matchId}).then((value) {
      List list = value.data;
      if (list.isEmpty) {
        return [];
      }
      return list.map((e) => SportMatch.fromJson(e)).toList();
    });
  }

  ///
  /// 比赛大小球指数
  ///
  static Future<BigSmallIndex> bosIndex(int matchId) async {
    return HttpRequest().get('/ssport/app/match/bos/index',
        params: {'matchId': matchId}).then((value) {
      return BigSmallIndex.fromJson(value.data);
    });
  }

  ///
  /// 比赛胜负指数
  ///
  static Future<WinLossIndex> wolIndex(int matchId) {
    return HttpRequest().get('/ssport/app/match/wol/index',
        params: {'matchId': matchId}).then((value) {
      return WinLossIndex.fromJson(value.data);
    });
  }

  ///
  /// 比赛主客队进球统计
  ///
  static Future<PointGoalIndex> pointGoalIndex(int matchId) {
    return HttpRequest().get('/ssport/app/match/goal/index',
        params: {'matchId': matchId}).then((value) {
      return PointGoalIndex.fromJson(value.data);
    });
  }

  ///
  /// 查询近期热门比赛
  ///
  static Future<List<SportMatch>> hotMatchList() {
    return HttpRequest().get('/ssport/app/match/hot/list').then((value) {
      return (value.data as List).map((e) => SportMatch.fromJson(e)).toList();
    });
  }
}
