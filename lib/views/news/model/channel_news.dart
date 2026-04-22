import 'package:iwacai_lottery_app/utils/date_util.dart';

class ChannelNews {
  List<TopNews> hotNews = [];
  List<TopNews> banners = [];
  List<TopNews> topNews = [];

  ChannelNews.fromJson(Map<String, dynamic> json) {
    if (json['hotNews'] != null) {
      hotNews
        ..clear()
        ..addAll(
            (json['hotNews'] as List).map((e) => TopNews.fromJson(e)).toList());
    }
    if (json['banners'] != null) {
      banners
        ..clear()
        ..addAll(
            (json['banners'] as List).map((e) => TopNews.fromJson(e)).toList());
    }
    if (json['topNews'] != null) {
      topNews
        ..clear()
        ..addAll(
            (json['topNews'] as List).map((e) => TopNews.fromJson(e)).toList());
    }
  }
}

class TopNews {
  late int newsId;
  late String title;
  late String summary;
  late String cover;
  late int top;
  late int hotLabel;
  late int hotIdx;
  late int type;
  late int views;
  late String realTime;
  late TimeDelta delta;

  TopNews.fromJson(Map<String, dynamic> json) {
    newsId = int.parse(json['newsId']);
    title = json['title'];
    summary = json['summary'] ?? '';
    cover = json['cover'] ?? '';
    top = json['top'] ?? 0;
    hotLabel = json['hotLabel'] ?? 0;
    hotIdx = json['hotIdx'] ?? 0;
    type = json['type'];
    views = json['views'] ?? 0;
    realTime = json['realTime'];
    delta = _timeDelta();
  }

  TimeDelta _timeDelta() {
    var dateTime = DateUtil.parse(realTime, pattern: 'yy.MM.dd HH:mm');
    return DateUtil.timeDeltaText(dateTime);
  }
}
