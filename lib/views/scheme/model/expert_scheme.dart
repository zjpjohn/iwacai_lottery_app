import 'package:iwacai_lottery_app/utils/date_util.dart';

class ExpertScheme {
  ///
  /// 方案编号
  String seqNo = '';

  ///
  /// 专家编号
  String expertNo = '';

  ///
  /// 专家名称
  String name = '';

  ///
  /// 专家头像
  String avatar = '';

  ///
  /// 专家擅长
  String zhong = '';

  ///
  /// 浏览量
  int browse = 0;

  ///
  /// 方案标题
  String title = '';

  ///
  /// 事件集合
  List<String> events = [];

  ///
  /// 最新时间
  String latestTime = '';

  ///
  /// 新格式化时间
  String formatTime = '';

  ///
  /// 时间偏移量
  late TimeDelta delta;

  ExpertScheme.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    expertNo = json['expertNo'];
    name = json['name'];
    avatar = json['avatar'];
    zhong = json['zhong'];
    browse = json['browse'];
    title = json['title'] ?? '';
    title = title.replaceAll('【情报】', '');
    latestTime = json['latestTime'];
    events = (json['events'] ?? []).cast<String>();
    formatTime = timeFormat();
    delta = _timeDelta();
  }

  String timeFormat() {
    return DateUtil.formatDate(
        DateUtil.parse(latestTime, pattern: 'yyyy/MM/dd HH:mm:ss'),
        format: 'yyyy/MM/dd HH:mm');
  }

  TimeDelta _timeDelta() {
    var dateTime = DateUtil.parse(latestTime, pattern: 'yyyy/MM/dd HH:mm');
    return DateUtil.timeDeltaText(dateTime);
  }
}
