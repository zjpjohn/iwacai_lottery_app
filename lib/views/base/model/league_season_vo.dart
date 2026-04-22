///
///
class LeagueSeasonVo {
  ///联赛标识
  late int leagueId;

  ///赛季标识
  late int seasonId;

  ///赛季名称
  late String season;

  ///是否为杯赛
  late int cup;

  ///杯赛轮次
  SeasonCupRound? cupRound;

  ///联赛轮次
  SeasonSubRound? subRound;

  LeagueSeasonVo.fromJson(Map<String, dynamic> json) {
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    season = json['season'];
    cup = json['cup'];
    if (json['cupRound'] != null) {
      cupRound = SeasonCupRound.fromJson(json['cupRound']);
    }
    if (json['subRound'] != null) {
      subRound = SeasonSubRound.fromJson(json['subRound']);
    }
  }
}

class SeasonCupRound {
  late LeagueSeasonCround currRound;
  late List<LeagueSeasonCround> stages;

  SeasonCupRound.fromJson(Map<String, dynamic> json) {
    currRound = LeagueSeasonCround.fromJson(json['currRound']);
    List list = json['stages'];
    stages = list.map((e) => LeagueSeasonCround.fromJson(e)).toList();
  }
}

class LeagueSeasonCround {
  late int id;
  late int leagueId;
  late int seasonId;
  late int stageId;
  late String name;
  late int sortNo;
  late int groupNum;
  late List<String>? groupList;
  late int rounded;
  late int grouped;
  late String gmtCreate;

  LeagueSeasonCround.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    stageId = int.parse(json['stageId']);
    name = json['name'];
    sortNo = json['sortNo'];
    groupNum = json['groupNum'];
    if (json['groupList'] != null) {
      List list = json['groupList'];
      groupList = list.cast<String>();
    }
    rounded = json['rounded'];
    grouped = json['grouped'];
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

class SeasonSubRound {
  late String currRound;
  late LeagueSeasonSround currStage;
  late List<LeagueSeasonSround> stages;

  SeasonSubRound.fromJson(Map<String, dynamic> json) {
    currRound = json['currRound'];
    currStage = LeagueSeasonSround.fromJson(json['currStage']);
    List list = json['stages'];
    stages = list.map((e) => LeagueSeasonSround.fromJson(e)).toList();
  }
}

class LeagueSeasonSround {
  late int id;
  late int leagueId;
  late int seasonId;
  late int stageId;
  late String nameCn;
  late String nameEn;
  late int roundNum;
  late List<String>? rounds;
  late String gmtCreate;

  LeagueSeasonSround.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    stageId = int.parse(json['stageId']);
    nameCn = json['nameCn'];
    nameEn = json['nameEn'];
    roundNum = json['roundNum'];
    List list = json['rounds'];
    rounds = list.cast<String>();
    gmtCreate = json['gmtCreate'];
  }
}

///
///
class LeagueNearestInfo {
  late int leagueId;
  late String name;
  late String logo;
  late int seasonId;
  late String season;
  late String rounds;
  late String current;
  late String nearDate;

  LeagueNearestInfo.fromJson(Map<String, dynamic> json) {
    leagueId = int.parse(json['leagueId']);
    name = json['name'];
    logo = json['logo'];
    seasonId = int.parse(json['seasonId']);
    season = json['season'];
    rounds = json['rounds'];
    current = json['current'];
    nearDate = json['nearDate'];
  }
}
