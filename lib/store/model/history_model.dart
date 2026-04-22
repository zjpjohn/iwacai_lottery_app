class HistoryInfo {
  ///页面路径
  String path;

  ///页面参数
  dynamic args;

  ///页面备注描述
  String? remark;

  HistoryInfo(this.path, this.args, this.remark);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['path'] = path;
    json['args'] = args;
    json['remark'] = remark;
    return json;
  }
}
