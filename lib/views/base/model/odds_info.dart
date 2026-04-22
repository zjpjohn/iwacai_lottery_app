///
///
class AsianOdds {
  late int id;
  late int matchId;
  late int leagueId;
  late int providerId;
  late String provider;
  late int oddsId;
  late int homeUpdown;
  late int awayUpdown;
  late AsianOddsVal initial;
  late AsianOddsVal instant;
  late String startTime;
  late String latestTime;
  late String gmtCreate;

  AsianOdds.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    providerId = int.parse(json['providerId']);
    oddsId = int.parse(json['oddsId']);
    provider = json['provider'] ?? '';
    homeUpdown = json['homeUpdown'];
    awayUpdown = json['awayUpdown'];
    initial = AsianOddsVal.fromJson(json['initial']);
    instant = AsianOddsVal.fromJson(json['instant']);
    startTime = json['startTime'] ?? '';
    latestTime = json['latestTime'] ?? '';
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

class AsianOddsHistory {
  late int id;
  late int matchId;
  late int leagueId;
  late int providerId;
  late int oddsId;
  late AsianOddsVal odds;
  late int homeUpdown;
  late int awayUpdown;
  late String gmtCreate;

  AsianOddsHistory.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    providerId = int.parse(json['providerId']);
    oddsId = int.parse(json['oddsId']);
    odds = AsianOddsVal.fromJson(json['odds']);
    homeUpdown = json['homeUpdown'];
    awayUpdown = json['awayUpdown'];
    gmtCreate = json['gmtCreate'];
  }
}

///
///
class EuroOdds {
  late int id;
  late int matchId;
  late int leagueId;
  late int providerId;
  late String providerName;
  late int oddsId;
  late EuroOddsVal initial;
  late EuroOddsVal instant;
  late int winUpdown;
  late int drawUpdown;
  late int loseUpdown;
  late String startTime;
  late String latestTime;
  late String gmtCreate;

  EuroOdds.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    providerId = int.parse(json['providerId']);
    oddsId = int.parse(json['oddsId']);
    providerName = json['providerName']??'';
    initial = EuroOddsVal.fromJson(json['initial']);
    instant = EuroOddsVal.fromJson(json['instant']);
    winUpdown = json['winUpdown'];
    drawUpdown = json['drawUpdown'];
    loseUpdown = json['loseUpdown'];
    startTime = json['startTime'];
    latestTime = json['latestTime'];
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

class EuroOddsHistory {
  late int id;
  late int matchId;
  late int leagueId;
  late int providerId;
  late int oddsId;
  late EuroOddsVal odds;
  late int winUpdown;
  late int drawUpdown;
  late int loseUpdown;
  late String gmtCreate;

  EuroOddsHistory.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    providerId = int.parse(json['providerId']);
    oddsId = int.parse(json['oddsId']);
    odds = EuroOddsVal.fromJson(json['odds']);
    winUpdown = json['winUpdown'];
    drawUpdown = json['drawUpdown'];
    loseUpdown = json['loseUpdown'];
    gmtCreate = json['gmtCreate'];
  }
}

///
///
class BosOdds {
  late int id;
  late int matchId;
  late int leagueId;
  late int providerId;
  late String provider;
  late int oddsId;
  late BosOddsVal initial;
  late BosOddsVal instant;
  late int bigUpdown;
  late int smallUpdown;
  late String startTime;
  late String latestTime;
  late String gmtCreate;

  BosOdds.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    providerId = int.parse(json['providerId']);
    oddsId = int.parse(json['oddsId']);
    provider = json['provider'] ?? '';
    initial = BosOddsVal.fromJson(json['initial']);
    instant = BosOddsVal.fromJson(json['instant']);
    bigUpdown = json['bigUpdown'];
    smallUpdown = json['smallUpdown'];
    startTime = json['startTime'];
    latestTime = json['latestTime'];
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

class BosOddsHistory {
  late int id;
  late int matchId;
  late int leagueId;
  late int providerId;
  late int oddsId;
  late BosOddsVal odds;
  late int bigUpdown;
  late int smallUpdown;
  late String gmtCreate;

  BosOddsHistory.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    leagueId = int.parse(json['leagueId']);
    providerId = int.parse(json['providerId']);
    oddsId = int.parse(json['oddsId']);
    odds = BosOddsVal.fromJson(json['odds']);
    bigUpdown = json['bigUpdown'];
    smallUpdown = json['smallUpdown'];
    gmtCreate = json['gmtCreate'];
  }
}

///
///
class AsianOddsVal {
  late String handicap;
  late String handicapNum;
  late double home;
  late double away;

  AsianOddsVal.fromJson(Map<String, dynamic> json) {
    handicap = json['handicap'];
    handicapNum = json['handicapNum'];
    home = json['home'];
    away = json['away'];
  }
}

///
///
class BosOddsVal {
  ///
  late String handicap;

  ///
  late String handicapNum;

  ///
  late double big;

  ///
  late double small;

  BosOddsVal.fromJson(Map<String, dynamic> json) {
    handicap = json['handicap'];
    handicapNum = json['handicapNum'];
    big = json['big'];
    small = json['small'];
  }
}

///
///
class EuroOddsVal {
  ///赔率
  late double win;
  late double draw;
  late double lose;

  ///凯利指数
  late double winKelly;
  late double drawKelly;
  late double loseKelly;

  ///返还率
  late double loseRetain;

  ///概率
  late double winChance;
  late double drawChance;
  late double loseChance;

  EuroOddsVal.fromJson(Map<String, dynamic> json) {
    win = json['win'];
    draw = json['draw'];
    lose = json['lose'];
    winKelly = json['winKelly'];
    drawKelly = json['drawKelly'];
    loseKelly = json['loseKelly'];
    loseRetain = json['loseRetain'];
    winChance = json['winChance'];
    drawChance = json['drawChance'];
    loseChance = json['loseChance'];
  }
}
