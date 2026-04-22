import 'package:iwacai_lottery_app/utils/date_util.dart';

///
///
class BillboardNews {
  late int newsId;
  late String title;
  late String summary;
  late String cover;
  late String realTime;
  late int views;
  late int votes;
  late int top;
  late int hotLabel;
  late int hotIdx;
  late TimeDelta delta;

  BillboardNews.fromJson(Map<String, dynamic> json) {
    newsId = int.parse(json['newsId']);
    title = json['title'];
    summary = json['summary'];
    cover = json['cover'];
    realTime = json['realTime'];
    views = json['views'] ?? 0;
    votes = json['votes'] ?? 0;
    top = json['top'] ?? 0;
    hotLabel = json['hotLabel'] ?? 0;
    hotIdx = json['hotIdx'] ?? 0;
    delta = _timeDelta();
  }

  TimeDelta _timeDelta() {
    var dateTime = DateUtil.parse(realTime, pattern: 'yyyy/MM/dd HH:mm');
    return DateUtil.timeDeltaText(dateTime);
  }
}
