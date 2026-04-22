import 'package:iwacai_lottery_app/utils/date_util.dart';

///
///
class SportTeam {
  ///
  late int id;
  late String nameCn;
  late String nameCnShort;
  late String nameEn;
  late String logo;
  late int countryId;
  late String city;
  late String introduce;
  late String setup;
  late String venue;
  late String website;
  late String remark;
  late int focused;
  late String gmtCreate;

  SportTeam.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    nameCn = json['nameCn'];
    nameCnShort = json['nameCnShort'];
    nameEn = json['nameEn'];
    logo = json['logo'];
    countryId = int.parse(json['countryId'] ?? '0');
    city = json['city'] ?? '';
    introduce = json['introduce'] ?? '';
    setup = json['setup'] ?? '';
    venue = json['venue'] ?? '';
    website = json['website'] ?? '';
    remark = json['remark'] ?? '';
    focused = json['focused'] ?? 0;
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

///
/// 关注球队信息
class FocusTeam {
  late int id;
  late int teamId;
  late String logo;
  late String nameCn;
  late String nameCnShort;
  late String subscribeTime;
  late String league;
  late int leagueId;
  late String vsDate;
  late String awayName;
  late int awayId;

  FocusTeam.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    teamId = int.parse(json['teamId']);
    nameCn = json['nameCn'] ?? '';
    logo = json['logo'] ?? '';
    nameCnShort = json['nameCnShort'] ?? '';
    league = json['league'] ?? '';
    leagueId = int.parse(json['leagueId'] ?? '0');
    awayName = json['awayName'] ?? '';
    awayId = int.parse(json['awayId'] ?? '0');
    subscribeTime = DateUtil.formatDate(
      DateUtil.parse(json['subscribeTime'], pattern: "yyyy/MM/dd HH:mm:ss"),
      format: 'yyyy/MM/dd HH:mm',
    );
    if (json['vsDate'] != null) {
      vsDate = DateUtil.formatDate(
        DateUtil.parse(json['vsDate'], pattern: "yyyy/MM/dd HH:mm:ss"),
        format: 'yy/MM/dd HH:mm',
      );
    }
  }
}
