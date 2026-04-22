import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
/// 统计类型
const Map<int, String> statsTypes = {
  1: '全部',
  2: '主场',
  3: '客场',
  4: '近6场',
};

///
///
typedef StatsConverter<T> = T Function(Map<String, dynamic> json);

///
/// 联赛统计信息
///
class StatsInfo<T> {
  late int id;
  late int leagueId;
  late int seasonId;
  late int teamId;
  late String team;
  late String teamLogo;
  late int played;
  late int rank;
  late EnumValue type;
  late T stats;
  late String latestTime;
  late String gmtCreate;

  StatsInfo.fromJson(Map<String, dynamic> json, StatsConverter<T> handle) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    teamId = int.parse(json['teamId']);
    team = json['team'] ?? '';
    teamLogo = json['teamLogo'] ?? '';
    played = json['played'];
    rank = json['rank'];
    type = EnumValue.fromJson(json['type']);
    stats = handle(json['stats']);
    latestTime = json['latestTime'] ?? '';
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

///
/// 大小球统计信息
class BigSmallStats {
  late int bigBall;
  late double bigRate;
  late int goDish;
  late double goRate;
  late int smallBall;
  late double smallRate;

  BigSmallStats.empty() {
    bigBall = 0;
    bigRate = 0;
    goDish = 0;
    goRate = 0;
    smallBall = 0;
    smallRate = 0;
  }

  BigSmallStats.fromJson(Map<String, dynamic> json) {
    bigBall = json['bigBall'] ?? 0;
    bigRate = json['bigRate'] ?? 0;
    goDish = json['goDish'] ?? 0;
    goRate = json['goRate'] ?? 0;
    smallBall = json['smallBall'] ?? 0;
    smallRate = json['smallRate'] ?? 0;
  }
}

///
/// 常见比分
class CommonGoalStats {
  late int drawOther;
  late int lossOther;
  late int winOther;
  late int score00;
  late int score01;
  late int score02;
  late int score03;
  late int score10;
  late int score11;
  late int score12;
  late int score13;
  late int score20;
  late int score21;
  late int score22;
  late int score23;
  late int score30;
  late int score31;
  late int score32;
  late int score33;

  CommonGoalStats.fromJson(Map<String, dynamic> json) {
    drawOther = json['drawOther'] ?? 0;
    lossOther = json['lossOther'] ?? 0;
    winOther = json['winOther'] ?? 0;
    score00 = json['score00'] ?? 0;
    score01 = json['score01'] ?? 0;
    score02 = json['score02'] ?? 0;
    score03 = json['score03'] ?? 0;
    score10 = json['score10'] ?? 0;
    score11 = json['score11'] ?? 0;
    score12 = json['score12'] ?? 0;
    score13 = json['score13'] ?? 0;
    score20 = json['score20'] ?? 0;
    score21 = json['score21'] ?? 0;
    score22 = json['score22'] ?? 0;
    score23 = json['score23'] ?? 0;
    score30 = json['score30'] ?? 0;
    score31 = json['score31'] ?? 0;
    score32 = json['score32'] ?? 0;
    score33 = json['score33'] ?? 0;
  }
}

///
/// 半场全场比分
class HalfAllStats {
  late int drawDraw;
  late int drawLose;
  late int drawWin;
  late int loseLose;
  late int loseDraw;
  late int loseWin;
  late int winDraw;
  late int winLose;
  late int winWin;

  HalfAllStats.fromJson(Map<String, dynamic> json) {
    drawDraw = json['drawDraw'] ?? 0;
    drawLose = json['drawLose'] ?? 0;
    drawWin = json['drawWin'] ?? 0;
    loseLose = json['loseLose'] ?? 0;
    loseDraw = json['loseDraw'] ?? 0;
    loseWin = json['loseWin'] ?? 0;
    winDraw = json['winDraw'] ?? 0;
    winLose = json['winLose'] ?? 0;
    winWin = json['winWin'] ?? 0;
  }
}

///
/// 半场得分
class HalfGoalStats {
  ///客场半场进球相同
  late int awayHalfEqual;

  ///客场半场进球较少
  late int awayHalfLess;

  ///客场半场进球较多
  late int awayHalfMore;

  ///半场进球相同
  late int halfEqual;

  ///半场进球较少
  late int halfLess;

  ///半场进球较多
  late int halfMore;

  ///主场半场进球相同
  late int homeHalfEqual;

  ///主场半场进球较少
  late int homeHalfLess;

  ///主场半场进球较多
  late int homeHalfMore;

  HalfGoalStats.fromJson(Map<String, dynamic> json) {
    awayHalfEqual = json['awayHalfEqual'] ?? 0;
    awayHalfLess = json['awayHalfLess'] ?? 0;
    awayHalfMore = json['awayHalfMore'] ?? 0;
    halfEqual = json['halfEqual'] ?? 0;
    halfLess = json['halfLess'] ?? 0;
    homeHalfEqual = json['homeHalfEqual'] ?? 0;
    homeHalfLess = json['homeHalfLess'] ?? 0;
    homeHalfMore = json['homeHalfMore'] ?? 0;
  }
}

///
/// 进球奇偶统计
class OddEvenStats {
  //全偶数
  late int even;

  //半场偶数
  late int halfEven;

  //半场奇数
  late int halfOdd;

  //全场奇数
  late int odd;

  OddEvenStats.fromJson(Map<String, dynamic> json) {
    even = json['even'] ?? 0;
    halfEven = json['halfEven'] ?? 0;
    halfOdd = json['halfOdd'] ?? 0;
    odd = json['odd'] ?? 0;
  }
}

///
///进球统计
class PointGoalStats {
  late int point0;
  late int point1;
  late int point2;
  late int point3;
  late int point4;
  late int point5;
  late int point6;
  late int point7;

  PointGoalStats.empty() {
    point0 = 0;
    point1 = 0;
    point2 = 0;
    point3 = 0;
    point4 = 0;
    point5 = 0;
    point6 = 0;
    point7 = 0;
  }

  PointGoalStats.fromJson(Map<String, dynamic> json) {
    point0 = json['point0'];
    point1 = json['point1'];
    point2 = json['point2'];
    point3 = json['point3'];
    point4 = json['point4'];
    point5 = json['point5'];
    point6 = json['point6'];
    point7 = json['point7'];
  }
}

///
///
class TeamTapeStats {
  //下盘
  late int downDish;

  //平盘
  late int drawDish;

  //频率
  late double drawRate;

  //走盘
  late int goDish;

  //失盘
  late int loseDish;

  //失盘率
  late double loseRate;

  //上盘
  late int upDish;

  //赢盘
  late int winDish;

  //赢盘率
  late double winRate;

  //净胜球
  late int margin;

  TeamTapeStats.fromJson(Map<String, dynamic> json) {
    downDish = json['downDish'];
    drawDish = json['drawDish'];
    drawRate = json['drawRate'];
    goDish = json['goDish'];
    loseDish = json['loseDish'];
    loseRate = json['loseRate'];
    upDish = json['upDish'];
    winDish = json['winDish'];
    winRate = json['winRate'];
    margin = json['margin'];
  }
}

///
///
class WinLossStats {
  //平手
  late int draw;

  //负1球
  late int lose1;

  //负2球
  late int lose2;

  //负3球
  late int lose3;

  //胜1球
  late int win1;

  //胜2球
  late int win2;

  //胜3球
  late int win3;

  WinLossStats.empty() {
    draw = 0;
    lose1 = 0;
    lose2 = 0;
    lose3 = 0;
    win1 = 0;
    win2 = 0;
    win3 = 0;
  }

  WinLossStats.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    lose1 = json['lose1'];
    lose2 = json['lose2'];
    lose3 = json['lose3'];
    win1 = json['win1'];
    win2 = json['win2'];
    win3 = json['win3'];
  }
}
