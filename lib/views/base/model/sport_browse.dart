import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

class SportBrowseRecord {
  late int id;
  late int userId;
  late EnumValue type;
  late int browseId;
  late BrowseContent browse;
  late String gmtCreate;

  SportBrowseRecord.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    userId = int.parse(json['userId']);
    type = EnumValue.fromJson(json['type']);
    browseId = int.parse(json['browseId']);
    browse = BrowseContent.fromJson(json['browse']);
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

class BrowseContent {
  String? name;
  String? logo;
  int? leagueId;
  int? homeId;
  String? home;
  String? homeLogo;
  int? awayId;
  String? away;
  String? awayLogo;
  String? vsDate;

  BrowseContent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    leagueId = int.parse(json['leagueId'] ?? '0');
    homeId = int.parse(json['homeId'] ?? '0');
    home = json['home'];
    homeLogo = json['homeLogo'];
    awayId = int.parse(json['awayId'] ?? '0');
    away = json['away'];
    awayLogo = json['awayLogo'];
    vsDate = json['vsDate'];
  }
}
