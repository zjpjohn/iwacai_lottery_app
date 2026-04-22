///
///
class OddsProvider {
  ///赔率公司标识
  late int id;

  ///赔率公司名称
  late String name;

  ///是否为交易所
  late int bourse;

  ///是否为主流公司
  late int primary;

  ///备注描述信息
  late String remark;

  ///创建时间
  late String gmtCreate;

  OddsProvider.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    bourse = json['bourse'];
    primary = json['primary'];
    remark = json['remark'] ?? '';
    gmtCreate = json['gmtCreate'];
  }
}
