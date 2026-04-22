class LeagueDate {
  ///
  ///联赛标识
  late int leagueId;

  ///联赛标识
  String logo = '';

  ///联赛名称
  String name = '';

  ///联赛国家
  String country = '';

  ///是否为杯赛:0-否,1-是
  late int cup;

  /// 联赛类型
  late int type;

  ///赛季标识
  late int seasonId;

  ///赛季阶段标识
  late int stageId;

  ///赛季阶段轮次
  late String round;

  /// 杯赛分组
  late String groups;

  /// 赛事数量
  late int matches;

  LeagueDate({
    this.leagueId = 0,
    this.name = '',
    this.country = '',
    this.type = 0,
    this.seasonId = 0,
    this.stageId = 0,
    this.round = '',
    this.groups = '',
    this.matches = 0,
  });

  LeagueDate.fromJson(Map<String, dynamic> json) {
    leagueId = int.parse(json['leagueId']);
    logo = json['logo'] ?? '';
    name = json['name'] ?? '';
    country = json['country'] ?? '';
    cup = json['cup'] ?? 0;
    type = json['type'] ?? 0;
    seasonId = int.parse(json['seasonId'] ?? '0');
    stageId = int.parse(json['stageId'] ?? '0');
    round = json['round'] ?? '';
    groups = json['groups'] ?? '';
    matches = json['matches'] ?? 0;
  }
}
