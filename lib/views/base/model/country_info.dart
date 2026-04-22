///
///
class CountryInfo {
  ///国家标识
  late int id;

  ///起始字母
  late String initial;

  ///国家名称
  late String name;

  ///国家logo
  late String logo;

  ///区域标识
  late int area;

  ///创建时间
  late String gmtCreate;

  ///国家联赛数量
  late int leagues;

  CountryInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    initial = json['initial'];
    name = json['name'];
    logo = json['logo'];
    area = json['area'];
    gmtCreate = json['gmtCreate'];
    leagues = json['leagues']??0;
  }
}
