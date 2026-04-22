///
///
class LeagueSeason {
  late int id;
  late int leagueId;
  late String name;
  late String maxRound;
  late int cup;
  late int seasonFlag;
  late String gmtCreate;

  LeagueSeason.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    name = json['name'];
    maxRound = json['maxRound'];
    cup = json['cup'];
    seasonFlag = json['seasonFlag'];
    gmtCreate = json['gmtCreate'];
  }
}
