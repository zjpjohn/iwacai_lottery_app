///
///
class TeamWitting {
  late int id;
  late int teamId;
  late int matchId;
  late String matchDate;
  late String creator;
  late int type;
  late int home;
  late int sport;
  late String content;
  late int state;
  late String gmtCreate;

  TeamWitting.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    teamId = int.parse(json['teamId']);
    matchId = int.parse(json['matchId']);
    matchDate = json['matchDate'];
    creator = json['creator'] ?? '';
    type = json['type'];
    home = json['home'];
    sport = json['sport'];
    content = json['content'];
    state = json['state'];
    gmtCreate = json['gmtCreate'];
  }
}

class TeamMatchWitting {
  late int matchId;
  late String matchDate;
  int? homeId;
  String? homeName;
  int? awayId;
  String? awayName;
  List<MatchWittingItem> items = [];

  TeamMatchWitting.fromJson(Map<String, dynamic> json) {
    matchId = int.parse(json['matchId']);
    matchDate = json['matchDate'];
    homeName = json['homeName'];
    awayName = json['awayName'];
    if (json['homeId'] != null) {
      homeId = int.parse(json['homeId']);
    }
    if (json['awayId'] != null) {
      awayId = int.parse(json['awayId']);
    }
    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((e) => MatchWittingItem.fromJson(e))
          .toList();
    }
  }
}

class MatchWittingItem {
  late int id;
  late int type;
  late int home;
  late String content;

  MatchWittingItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    type = json['type'];
    home = json['home'];
    content = json['content'] ?? '';
  }
}
