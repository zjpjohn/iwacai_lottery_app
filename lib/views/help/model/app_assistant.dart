///
///
class AppAssistant {
  ///
  late int id;

  ///
  late String type;

  ///
  late String title;

  ///
  late String content;

  ///
  late int sort;

  AppAssistant.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    sort = json['sort'];
    type = json['type'];
    title = json['title'];
    content = json['content'] ?? '';
  }
}
