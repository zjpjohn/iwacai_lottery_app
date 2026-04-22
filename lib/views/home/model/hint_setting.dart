///
/// 提醒设置内容
///
class HintSetting {
  ///
  /// 提醒总开关(0-关闭,1-打开)
  int global = 0;

  ///
  /// 提醒比赛范围(1-全部,2-五大联赛,3-主流联赛)
  int range = 1;

  ///
  /// 进球(0-关闭,1-开启)
  int goal = 1;

  ///
  /// 红牌(0-关闭,1-开启)
  int red = 0;

  ///
  /// 黄牌(0-关闭,1-开启)
  int yellow = 0;

  ///
  /// 比赛开始(0-关闭,1-开启)
  int start = 0;

  ///
  /// 比赛结束(0-关闭,1-开启)
  int end = 0;

  ///
  /// 弹层(0-关闭,1-开启)
  int overlay = 1;

  ///
  /// 震动(0-关闭,1-开启)
  int vibrate = 1;

  ///
  /// 声音(0-关闭,1-开启)
  int sound = 1;

  HintSetting();

  HintSetting.fromJson(Map<dynamic, dynamic> json) {
    global = json['global'] ?? 0;
    range = json['range'] ?? 1;
    goal = json['goal'] ?? 1;
    red = json['red'] ?? 0;
    yellow = json['yellow'] ?? 0;
    start = json['start'] ?? 0;
    end = json['end'] ?? 0;
    overlay = json['overlay'] ?? 1;
    vibrate = json['vibrate'] ?? 1;
    sound = json['sound'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'global': global,
      'range': range,
      'goal': goal,
      'red': red,
      'yellow': yellow,
      'overlay': overlay,
      'vibrate': vibrate,
      'sound': sound,
    };
  }
}
