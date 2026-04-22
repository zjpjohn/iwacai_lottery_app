///
///
class SeasonSround {
  late int id;
  late int leagueId;
  late int seasonId;
  late int stageId;
  late String nameCn;
  late String nameEn;
  int roundNum = 0;
  List<String> rounds = [];

  SeasonSround.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    seasonId = int.parse(json['seasonId']);
    stageId = int.parse(json['stageId']);
    nameCn = json['nameCn'];
    nameEn = json['nameEn'];
    roundNum = json['roundNum'] ?? 0;
    rounds = json['rounds'] ?? [];
  }
}
