import 'dart:convert';

import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
///新闻资讯
///
class SportNews {
  ///
  ///
  late int newsId;

  ///
  ///
  String title = '';

  ///
  ///
  String catalog = '';

  ///
  ///
  String cover = '';

  ///
  ///
  String summary = '';

  ///
  ///
  String content = '';

  ///
  ///
  int views = 0;

  ///
  ///
  int votes = 0;

  ///
  ///
  int praised = 0;

  ///
  ///
  int hotLabel = 0;

  ///
  ///
  int hotIdx = 0;

  ///
  ///
  String labelName = '';

  ///
  ///
  int top = 0;

  ///
  ///1-图文;2-视频资讯
  late int srcType;

  ///
  ///
  late EnumValue type;

  ///
  ///
  String realTime = '';

  ///
  ///
  late TimeDelta delta;

  ///
  /// 相关内容
  List<Relate> relates = [];

  ///
  /// 相关话题
  List<Topic> topics = [];

  ///
  ///
  VideoContent? videoContent;

  SportNews.fromJson(Map<String, dynamic> data) {
    newsId = int.parse(data['newsId']);
    title = data['title'];
    cover = data['cover'] ?? '';
    catalog = data['catalog'] ?? '';
    summary = data['summary'] ?? '';
    content = data['content'] ?? '';
    realTime = data['realTime'];
    delta = _timeDelta();
    views = data['views'] ?? 0;
    votes = data['votes'] ?? 0;
    praised = data['praised'] ?? 0;
    labelName = data['labelName'];
    hotLabel = data['hotLabel'] ?? 0;
    hotIdx = data['hotIdx'] ?? 0;
    top = data['top'] ?? 0;
    srcType = data['srcType'];
    type = EnumValue.fromJson(data['type']);
    if (srcType == 2 && data['content'] != null) {
      videoContent = VideoContent.fromJson(json.decode(data['content']));
    }
    if (data['relates'] != null) {
      relates =
          (data['relates'] as List).map((e) => Relate.fromJson(e)).toList();
    }
    if (data['topics'] != null) {
      topics = (data['topics'] as List).map((e) => Topic.fromJson(e)).toList();
    }
  }

  TimeDelta _timeDelta() {
    var dateTime = DateUtil.parse(realTime, pattern: 'yy.MM.dd HH:mm');
    return DateUtil.timeDeltaText(dateTime);
  }
}

class Relate {
  late EnumValue type;
  late Map<String, dynamic> params;

  Relate.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    params = json['params'];
  }

  Relate({
    required this.type,
    required this.params,
  });
}

class Topic {
  late int topicId;
  late String topic;

  Topic.fromJson(Map<String, dynamic> json) {
    topicId = int.parse(json['topicId']);
    topic = json['topic'];
  }
}

///
///
class VideoContent {
  late int width;
  late int height;
  late int size;
  late String videoUrl;
  late int draggable;
  late int duration;
  late String videoCover;

  VideoContent.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    size = json['size'];
    videoUrl = json['video_url'];
    draggable = json['draggable'];
    duration = json['duration'];
    videoCover = json['video_cover'];
  }
}
