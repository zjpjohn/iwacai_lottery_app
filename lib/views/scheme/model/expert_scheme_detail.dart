///
///
class ExpSchemeDetail {
  String seqNo = '';
  String expertNo = '';
  String name = '';
  String avatar = '';
  String zhong = '';
  int browse = 0;
  int praise = 0;
  int subscribes = 0;
  int browses = 0;
  int praises = 0;
  String title = '';
  String gmtCreate = '';
  String content = '';
  List<SchemeValue> items = [];
  int hasPraised = 0;
  int hasSubscribed = 0;

  ExpSchemeDetail.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    expertNo = json['expertNo'];
    name = json['name'];
    avatar = json['avatar'];
    zhong = json['zhong'];
    browse = json['browse'];
    praise = json['praise'];
    subscribes = json['subscribes'];
    browses = json['browses'];
    praises = json['praises'];
    title = json['title'];
    gmtCreate = json['gmtCreate'];
    content = json['content'];
    hasPraised = json['hasPraised'] ?? 0;
    hasSubscribed = json['hasSubscribed'] ?? 0;
    items = json['items']
        .map<SchemeValue>((value) => SchemeValue.fromJson(value))
        .toList();
    content = content
        .replaceAll('<p></p>', '')
        .replaceAll('<p><br></p>', '')
        .replaceAll('<br>', '');
  }
}

class SchemeValue {
  String event = '';
  String week = '';
  String time = '';
  String tag = '';
  String name = '';
  String option = '';

  SchemeValue.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    week = json['week'] ?? '';
    time = json['time'];
    tag = json['tag'];
    name = json['name'];
    option = json['option'];
  }
}
