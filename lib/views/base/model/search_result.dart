///
/// 搜索历史
///
class SearchResult {
  late int id;
  late String name;
  late int type;
  late int relateId;
  late String relateName;

  SearchResult.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    type = json['type'];
    relateId = int.parse(json['relateId']);
    relateName = json['relateName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': '$id',
      'name': name,
      'type': type,
      'relateId': '$relateId',
      'relateName': relateName,
    };
  }
}
