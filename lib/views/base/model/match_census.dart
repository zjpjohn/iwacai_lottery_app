///
///
class MatchCensus {
  int? id;
  int? matchId;
  int? homeId;
  int? awayId;
  String? gmtCreate;
  late MatchCensusVal home;
  late MatchCensusVal away;

  MatchCensus.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    homeId = int.parse(json['homeId']);
    home = MatchCensusVal.fromJson(json['home']);
    awayId = int.parse(json['awayId']);
    away = MatchCensusVal.fromJson(json['away']);
    gmtCreate = json['gmtCreate'] ?? '';
  }

  MatchCensus.empty() {
    home = MatchCensusVal.fromJson({'home': 1});
    away = MatchCensusVal.fromJson({'home': 0});
  }
}

class MatchCensusVal {
  late String controlStr;
  late int cornerKick;
  late int home;
  late String passStr;
  late int rcard;
  late int shoot;
  late int shootOn;
  late int ycard;

  MatchCensusVal.fromJson(Map<String, dynamic> json) {
    controlStr = json['controlStr'] ?? '100%';
    cornerKick = json['cornerKick'] ?? 0;
    home = json['home'];
    passStr = json['passStr'] ?? '';
    rcard = json['rcard'] ?? 0;
    shoot = json['shoot'] ?? 0;
    shootOn = json['shootOn'] ?? 0;
    ycard = json['ycard'] ?? 0;
  }
}
