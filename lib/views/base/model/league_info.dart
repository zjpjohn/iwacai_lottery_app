import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';

///
///
class LeagueInfo {
  ///联赛标识
  late int id;

  ///联赛名称
  late String name;

  ///联赛首字母
  late String initial;

  ///联赛logo
  late String logo;

  ///联赛区域
  late int area;

  ///联赛国家标识
  late int countryId;

  ///联赛球队数量
  late int teams;

  ///联赛级别
  late int level;

  ///联赛类型
  late int type;

  ///是否为杯赛
  late int cup;

  ///是否为热门赛事
  late int hot;

  ///是否主流赛事
  late int main;

  ///是否关注联赛
  late int focused;

  ///联赛备注
  late String remark;

  ///联赛规则
  late String rule;

  ///创建时间
  late String gmtCreate;

  LeagueInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    initial = json['initial'];
    logo = json['logo'] ?? '';
    area = json['area'];
    countryId = int.parse(json['countryId'] ?? '0');
    teams = json['teams'] ?? 0;
    level = json['level'] ?? 0;
    type = json['type'];
    cup = json['cup'];
    hot = json['hot'] ?? 0;
    main = json['main'] ?? 0;
    focused = json['focused'] ?? 0;
    remark = json['remark'] ?? '';
    rule = json['rule'] ?? '';
    gmtCreate = json['gmtCreate'] ?? '';
  }
}

///
///
class FocusLeague {
  late int id;
  late int leagueId;
  late String name;
  late String logo;
  late int teams;
  late int type;
  late int main;
  late int five;
  late String subscribeTime;
  late int matchId;
  late String vsDate;
  late int homeId;
  late String homeName;
  late String homeLogo;
  late int awayId;
  late String awayName;
  late String awayLogo;
  late EnumValue state;
  late MatchResultVal home;
  late MatchResultVal away;

  FocusLeague.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    leagueId = int.parse(json['leagueId']);
    name = json['name'] ?? '';
    logo = json['logo'] ?? '';
    teams = json['teams'] ?? 0;
    type = json['type'];
    main = json['main'];
    five = json['five'];
    matchId = int.parse(json['matchId'] ?? '0');
    homeId = int.parse(json['homeId'] ?? '0');
    homeName = json['homeName'] ?? '';
    homeLogo = json['homeLogo'] ?? '';
    awayId = int.parse(json['awayId'] ?? '0');
    awayName = json['awayName'] ?? '';
    awayLogo = json['awayLogo'] ?? '';

    home = MatchResultVal.fromJson(json['home']);
    away = MatchResultVal.fromJson(json['away']);
    state = EnumValue.fromJson(json['state']);
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
