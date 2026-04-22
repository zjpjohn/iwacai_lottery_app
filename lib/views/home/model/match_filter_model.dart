///
///
///
class MatchFilter {
  late int id;
  late String name;
  late String logo;
  late int type;
  late int amount;

  MatchFilter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    type = json['type'];
    amount = json['amount'];
  }
}
