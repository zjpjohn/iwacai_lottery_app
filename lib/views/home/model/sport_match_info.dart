import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';

import '../../base/model/odds_info.dart';

///
///
class SportMatch {
  ///
  late int id;

  ///比赛标识
  late int matchId;

  ///联赛标识
  late int leagueId;

  ///联赛名称
  late String league;

  ///赛季标识
  late int seasonId;

  ///阶段标识
  late int stageId;

  ///比赛伦次
  late String round;

  ///额外分组信息
  late String groups;

  ///主队标识
  late int homeId;

  ///主队名称
  late String homeName;

  ///主队logo
  late String homeLogo;

  ///客队标识
  late int awayId;

  ///客队名称
  late String awayName;

  ///客队logo
  late String awayLogo;

  ///比赛状态
  late EnumValue state;

  ///主队比赛结果
  late MatchResultVal home;

  ///客队比赛结果
  late MatchResultVal away;

  ///比赛日期
  late String vsDate = '';

  //比赛时间
  late DateTime vsDateTime;

  ///是否已关注比赛
  late int focused;

  /// 主队排名
  int? homeRank;

  ///主队近期请报数量
  int? homeWits;

  /// 客队排名
  int? awayRank;

  ///客队情报数量
  int? awayWits;

  ///平均欧指赔率
  MatchEuroOdds? euroOdds;

  SportMatch.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    league = json['league'] ?? '';
    seasonId = int.parse(json['seasonId']);
    stageId = int.parse(json['stageId']);
    round = json['round'] ?? '';
    groups = json['groups'] ?? '';
    homeId = int.parse(json['homeId']);
    homeName = json['homeName'] ?? '';
    homeLogo = json['homeLogo'] ?? '';
    homeRank = json['homeRank'];
    homeWits = json['homeWits'];
    awayId = int.parse(json['awayId']);
    awayName = json['awayName'] ?? '';
    awayLogo = json['awayLogo'] ?? '';
    awayRank = json['awayRank'];
    awayWits = json['awayWits'];
    home = MatchResultVal.fromJson(json['home']);
    away = MatchResultVal.fromJson(json['away']);
    state = EnumValue.fromJson(json['state']);
    vsDate = json['vsDate'];
    vsDateTime = DateUtil.parse(vsDate, pattern: 'yyyy/MM/dd HH:mm:ss');
    focused = json['focused'] ?? 0;
    if (json['euroOdds'] != null) {
      euroOdds = MatchEuroOdds.fromJson(json['euroOdds']);
    }
  }

  String matchRound() {
    RegExp regExp = RegExp(r'\d+$');
    if (regExp.hasMatch(round)) {
      return '第$round轮';
    }
    return round;
  }

  String matchResult(int teamId) {
    if (teamId == homeId) {
      return home.matchResult();
    }
    return away.matchResult();
  }

  bool isUnStart() {
    return state.value == 0;
  }

  bool isCanceled() {
    return state.value == 3 ||
        state.value == 4 ||
        state.value == 5 ||
        state.value == 8;
  }

  bool isUnknown() {
    return state.value == 6;
  }

  bool isDoingOrCompleted() {
    return state.value == 1 ||
        state.value == 2 ||
        state.value == 9 ||
        state.value == 11 ||
        state.value == 12 ||
        state.value == 13 ||
        state.value == 14;
  }

  bool isDoing() {
    return state.value == 1 ||
        state.value == 9 ||
        state.value == 11 ||
        state.value == 12 ||
        state.value == 13 ||
        state.value == 14;
  }

  bool isCompleted() {
    return state.value == 2 || state.value == 7;
  }
}

///
/// 比赛欧指赔率
class MatchEuroOdds {
  ///
  /// 初始赔率
  late EuroOddsVal initial;

  ///即时赔率
  late EuroOddsVal instant;

  /// 赢赔率变化
  late int winUpdown;

  ///平局赔率变化
  late int drawUpdown;

  ///负赔率变化
  late int loseUpdown;

  MatchEuroOdds.fromJson(Map<String, dynamic> json) {
    initial = EuroOddsVal.fromJson(json['initial']);
    instant = EuroOddsVal.fromJson(json['instant']);
    winUpdown = json['winUpdown'] ?? 0;
    drawUpdown = json['drawUpdown'] ?? 0;
    loseUpdown = json['loseUpdown'] ?? 0;
  }
}

class MatchResultVal {
  ///全场比分
  late int score;

  ///半场比分
  late int halfScore;

  ///全场比赛结果
  late int result;

  ///半场比赛结果
  late int halfResult;

  ///角球
  late int corner;

  ///红牌
  late int redCard;

  ///黄牌
  late int yellowCard;

  MatchResultVal.fromJson(Map<String, dynamic> json) {
    score = json['score'] ?? 0;
    halfScore = json['halfScore'] ?? 0;
    result = json['result'] ?? 1;
    halfResult = json['halfResult'] ?? 1;
    corner = json['corner'] ?? 0;
    redCard = json['redCard'] ?? 0;
    yellowCard = json['yellowCard'] ?? 0;
  }

  String matchResult() {
    return switch (result) {
      0 => '胜',
      1 => '平',
      2 => '负',
      _ => '未知',
    };
  }
}

class LeagueSchedule {
  late LeagueInfo league;
  LeagueSeason? season;
  List<SportMatch> matches = [];

  LeagueSchedule.fromJson(Map<String, dynamic> json) {
    league = LeagueInfo.fromJson(json['league']);
    if (json['season'] != null) {
      season = LeagueSeason.fromJson(json['season']);
    }
    if (json['matches'] != null) {
      matches =
          (json['matches'] as List).map((e) => SportMatch.fromJson(e)).toList();
    }
  }
}
