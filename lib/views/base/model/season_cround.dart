///
///
class SeasonCround {
  late int id;
  late int leagueId;
  late int seasonId;
  late int stageId;
  late String name;
  late int sortNo;
  int groupNum = 0;
  List<String> groupList = [];
  late int rounded;
  late int grouped;

  SeasonCround.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    stageId = int.parse(json['stageId']);
    name = json['name'];
    sortNo = json['sortNo'];
    groupNum = json['groupNum'] ?? 0;
    groupList = json['groupList'] ?? [];
    rounded = json['rounded'] ?? 0;
    grouped = json['grouped'] ?? 0;
  }
}
