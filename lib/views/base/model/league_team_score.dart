import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
///
class LeagueTeamScore {
  ///
  late int id;

  //联赛标识
  late int leagueId;

  //赛季名称
  late int seasonId;

  //球队标识
  late int teamId;

  ///
  late String name;

  ///
  late String nameShort;

  ///
  late String logo;

  //排名类型:1-总榜,2-主场,3-客场,4-近6场
  late EnumValue type;

  //积分排名
  late int rank;

  //比赛总场次
  late int played;

  //积分
  late int point;

  //排名统计信息
  late TeamRankStats rankStats;

  //最近更新时间
  late String latestTime;

  //创建时间
  late String gmtCreate;

  LeagueTeamScore.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    teamId = int.parse(json['teamId']);
    name = json['name'] ?? '';
    nameShort = json['nameShort'] ?? '';
    logo = json['logo'] ?? '';
    type = EnumValue.fromJson(json['type']);
    rank = json['rank'];
    played = json['played'];
    point = json['point'];
    rankStats = TeamRankStats.fromJson(json['rankStats']);
    latestTime = json['latestTime'];
    gmtCreate = json['gmtCreate'];
  }
}

class TeamRankStats {
//胜场数
  late int win;

  //平局场数
  late int draw;

  //负场数
  late int lose;

  //净胜
  late int goalDif;

  //失球
  late int goalsLoss;

  //进球
  late int goalsFor;

  TeamRankStats.fromJson(Map<String, dynamic> json) {
    win = json['win'];
    draw = json['draw'];
    lose = json['lose'];
    goalDif = json['goalDif'];
    goalsLoss = json['goalsLoss'];
    goalsFor = json['goalsFor'];
  }
}
