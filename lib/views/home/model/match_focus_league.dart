///
/// 订阅赛事联赛信息
///
class MatchFocusLeague {
  ///
  late int leagueId;

  ///
  late String league;

  ///
  late String logo;

  ///
  late int matches;

  MatchFocusLeague.fromJson(Map<String, dynamic> json) {
    leagueId = int.parse(json['leagueId']);
    league = json['league'] ?? '';
    logo = json['logo'] ?? '';
    matches = json['matches'] ?? 0;
  }
}
