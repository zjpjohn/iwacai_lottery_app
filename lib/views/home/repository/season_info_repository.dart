import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season_vo.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';

///
///
class SeasonInfoRepository {
  ///
  /// 查询联赛赛季集合
  ///
  static Future<List<LeagueSeason>> leagueSeasons(int leagueId) {
    return HttpRequest()
        .get('/ssport/share/season/list/$leagueId')
        .then((value) {
      List list = value.data;
      return list.map((e) => LeagueSeason.fromJson(e)).toList();
    });
  }

  ///
  /// 查询联赛最新赛季
  ///
  static Future<LeagueSeasonVo?> latestSeason(int leagueId) {
    return HttpRequest()
        .get('/ssport/share/season/latest/$leagueId')
        .then((value) {
      return value.data != null ? LeagueSeasonVo.fromJson(value.data) : null;
    });
  }

  ///
  /// 查询指定赛季
  ///
  static Future<LeagueSeasonVo?> leagueSeason(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/season/$seasonId/detail')
        .then((value) {
      return value.data != null ? LeagueSeasonVo.fromJson(value.data) : null;
    });
  }

  ///
  /// 查询杯赛指定赛季的轮次信息
  ///
  static Future<List<LeagueSeasonCround>> seasonCupRounds(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/season/cup-$seasonId/rounds')
        .then((value) {
      List list = value.data;
      return list.map((e) => LeagueSeasonCround.fromJson(e)).toList();
    });
  }

  ///
  /// 查询联赛指定赛季的轮次信息
  ///
  static Future<List<LeagueSeasonSround>> seasonSubRounds(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/season/sub-$seasonId/rounds')
        .then((value) {
      List list = value.data;
      return list.map((e) => LeagueSeasonSround.fromJson(e)).toList();
    });
  }

  ///
  /// 查询联赛赛季积分榜
  ///
  static Future<List<LeagueTeamScore>> teamScores(
      {required int seasonId, required int type}) {
    return HttpRequest()
        .get('/ssport/share/season/table/$seasonId-$type')
        .then((value) {
      List list = value.data ?? [];
      return list
          .map((e) => LeagueTeamScore.fromJson(e))
          .where((element) => element.name.isNotEmpty)
          .toList();
    });
  }

  ///
  /// 联赛首页积分榜
  ///
  static Future<List<LeagueTeamScore>> seasonScores(int seasonId) {
    return HttpRequest().get(
      '/ssport/share/season/table',
      params: {'seasonId': seasonId},
    ).then((value) {
      List list = value.data ?? [];
      return list.map((e) => LeagueTeamScore.fromJson(e)).toList();
    });
  }
}
