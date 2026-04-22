import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
///
///
class SportNewsTopic {
  late int id;
  late String seqNo;
  late int type;
  late String name;
  late String title;
  late String subtitle;
  late String cover;
  late String background;
  late int hotLabel;
  late int hotIdx;
  late int news;

  SportNewsTopic.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    seqNo = json['seqNo'];
    type = json['type'];
    name = json['name'];
    title = json['title'];
    subtitle = json['subtitle'] ?? '';
    cover = json['cover'];
    background = json['background'];
    hotLabel = json['hotLabel'];
    hotIdx = json['hotIdx'];
    news = json['news'];
  }
}

///
///
class TopicNewsItem {
  late int id;
  late String seqNo;
  late String title;
  late String cover;
  late String catalog;
  late String summary;
  late int views;
  late int votes;
  late String realTime;
  late int srcType;
  late EnumValue type;
  late int five;
  late int top;
  late int hotLabel;
  late int hotIdx;
  late int label;
  late String labelName;
  late TimeDelta delta;

  TopicNewsItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    seqNo = json['seqNo'];
    title = json['title'];
    cover = json['cover'];
    catalog = json['catalog'];
    summary = json['summary'];
    views = json['views'];
    votes = json['votes'];
    realTime = json['realTime'];
    srcType = json['srcType'];
    type = EnumValue.fromJson(json['type']);
    five = json['five'];
    top = json['top'];
    hotLabel = json['hotLabel'];
    hotIdx = json['hotIdx'];
    label = json['label'];
    labelName = json['labelName'];
    delta = _timeDelta();
  }

  TimeDelta _timeDelta() {
    var dateTime = DateUtil.parse(realTime, pattern: 'yy/MM/dd HH:mm');
    return DateUtil.timeDeltaText(dateTime);
  }
}
