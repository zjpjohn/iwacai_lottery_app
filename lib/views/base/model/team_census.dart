///
///
class TeamCensus {
  ///
  late int id;

  //赛季标识
  late int seasonId;

  //球队标识
  late int teamId;

  //全部统计数据
  late TeamStatVal allData;

  //主场统计数据
  late TeamStatVal homeData;

  //客场统计
  late TeamStatVal awayData;

  //最新更新时间
  late String latestTime;

  //创建时间
  late String gmtCreate;

  TeamCensus.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    seasonId = int.parse(json['seasonId']);
    teamId = int.parse(json['teamId']);
    allData = TeamStatVal.fromJson(json['allData']);
    homeData = TeamStatVal.fromJson(json['homeData']);
    awayData = TeamStatVal.fromJson(json['awayData']);
    latestTime = json['latestTime'];
    gmtCreate = json['gmtCreate'];
  }
}

class TeamStatVal {
  late double attackToScoreRate;
  late double averageLost;
  late double averageScore;
  late double beCornerKick;
  late double beFreeKick;
  late double beShootOn;
  late double beShooted;
  late double controlTime;
  late double cornerKick;
  late double dangerousAttack;
  late double freeKick;
  late double frontFreeKick;
  late double lostScoreRate;
  late double passRate;
  late double shoot;
  late double shootOn;

  TeamStatVal.empty() {
    attackToScoreRate = 0;
    averageLost = 0;
    averageScore = 0;
    beCornerKick = 0;
    beFreeKick = 0;
    beShootOn = 0;
    beShooted = 0;
    controlTime = 0;
    cornerKick = 0;
    dangerousAttack = 0;
    freeKick = 0;
    frontFreeKick = 0;
    lostScoreRate = 0;
    passRate = 0;
    shoot = 0;
    shootOn = 0;
  }

  TeamStatVal.fromJson(Map<String, dynamic> json) {
    attackToScoreRate = json['attackToScoreRate'];
    averageLost = json['averageLost'];
    averageScore = json['averageScore'];
    beCornerKick = json['beCornerKick'];
    beFreeKick = json['beFreeKick'];
    beShootOn = json['beShootOn'];
    beShooted = json['beShooted'];
    controlTime = json['controlTime'];
    cornerKick = json['cornerKick'];
    dangerousAttack = json['dangerousAttack'];
    freeKick = json['freeKick'];
    frontFreeKick = json['frontFreeKick'];
    lostScoreRate = json['lostScoreRate'];
    passRate = json['passRate'];
    shoot = json['shoot'];
    shootOn = json['shootOn'];
  }
}
