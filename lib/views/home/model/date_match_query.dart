import 'package:iwacai_lottery_app/utils/date_util.dart';

class DateMatchQuery {
  ///
  /// 分页页码
  int page;

  ///
  /// 每页数据
  int limit;

  ///
  /// 赛季阶段标识
  int? stageId;

  ///
  /// 联赛标识
  int? leagueId;

  ///
  /// 所属国家标识
  int? countryId;

  ///
  /// 日期
  DateTime date;

  ///比赛状态:0-完结,1-未完结,空-查全部
  int? state;

  DateMatchQuery({
    this.page = 1,
    this.limit = 10,
    this.state,
    this.stageId,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['page'] = page;
    json['limit'] = limit;
    json['state'] = state;
    json['stageId'] = stageId;
    json['leagueId'] = leagueId;
    json['countryId'] = countryId;
    json['date'] = DateUtil.formatDate(
      date,
      format: 'yyyy-MM-dd',
    );
    return json;
  }
}
