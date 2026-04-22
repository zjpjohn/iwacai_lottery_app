import 'package:iwacai_lottery_app/views/base/model/league_stats.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';

///
///
class MatchTeamStats {
  ///球队标识
  late int teamId;

  ///球队名称
  late String name;

  ///球队logo
  late String logo;

  ///球队大小球统计
  StatsInfo<BigSmallStats>? bigSmall;

  ///球队积分榜排名信息
  LeagueTeamScore? teamScore;

  ///球队近期赛事
  List<SportMatch> recentMatches = [];

  ///对战结果
  BattleResult battleResult = BattleResult();

  MatchTeamStats.fromJson(Map<String, dynamic> json) {
    teamId = int.parse(json['teamId']);
    name = json['name'];
    logo = json['logo'];
    if (json['bigSmall'] != null) {
      bigSmall = StatsInfo.fromJson(
          json['bigSmall'], (v) => BigSmallStats.fromJson(v));
    }
    if (json['teamScore'] != null) {
      teamScore = LeagueTeamScore.fromJson(json['teamScore']);
    }
    if (json['recentMatches'] != null) {
      recentMatches = (json['recentMatches'] as List)
          .map((e) => SportMatch.fromJson(e))
          .toList();
      battleResult.calcMatches(recentMatches, teamId);
    }
  }
}

class BattleResult {
  int games = 0;
  int goal = 0;
  int lose = 0;
  int win = 0;
  int draw = 0;
  int loss = 0;

  BattleResult({
    this.games = 0,
    this.goal = 0,
    this.lose = 0,
    this.win = 0,
    this.draw = 0,
    this.loss = 0,
  });

  String winRate() {
    if (games == 0) {
      return '0%';
    }
    return (win * 100 / games).toStringAsFixed(0) + '%';
  }

  void calcMatches(List<SportMatch> matches, int teamId) {
    if (matches.isNotEmpty) {
      games = matches.length;
      List<SportMatch> home = matches.where((e) => e.homeId == teamId).toList();
      List<SportMatch> away = matches.where((e) => e.awayId == teamId).toList();
      if (home.isNotEmpty) {
        goal += home.map((e) => e.home.score).reduce((v, e) => v + e);
        lose += home.map((e) => e.away.score).reduce((v, e) => v + e);
      }
      if (away.isNotEmpty) {
        goal += away.map((e) => e.away.score).reduce((v, e) => v + e);
        lose += away.map((e) => e.home.score).reduce((v, e) => v + e);
      }
      win = matches
          .where((e) =>
              (e.homeId == teamId && e.home.result == 0) ||
              (e.awayId == teamId && e.away.result == 0))
          .length;
      draw = matches
          .where((e) =>
              (e.homeId == teamId && e.home.result == 1) ||
              (e.awayId == teamId && e.away.result == 1))
          .length;
      loss = matches
          .where((e) =>
              (e.homeId == teamId && e.home.result == 2) ||
              (e.awayId == teamId && e.away.result == 2))
          .length;
    }
  }
}
