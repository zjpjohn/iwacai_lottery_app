import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

class MatchEvent {
  ///
  late int id;
  late int matchId;
  late int teamId;
  late String team;
  late int home;
  late EnumValue type;
  late String player;
  late String elapse;

  MatchEvent.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    matchId = int.parse(json['matchId']);
    teamId = int.parse(json['teamId']);
    team = json['team'];
    home = json['home'];
    type = EnumValue.fromJson(json['type']);
    player = json['player'] ?? '';
    elapse = json['elapse'];
  }
}
