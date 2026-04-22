import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/storage.dart';
import 'package:iwacai_lottery_app/views/home/model/hint_setting.dart';

const String settingKey = 'hint_setting';

class MatchSettingController extends GetxController {
  ///
  ///
  static MatchSettingController? _instance;

  factory MatchSettingController() {
    MatchSettingController._instance ??=
        Get.put(MatchSettingController._initialize());
    return MatchSettingController._instance!;
  }

  MatchSettingController._initialize() {
    _setting = Storage().getObj(
      settingKey,
      (v) => HintSetting.fromJson(v),
      defValue: HintSetting(),
    )!;
  }

  ///
  /// 提醒设置
  late HintSetting _setting;

  HintSetting get setting => _setting;

  void setRange(int range) {
    _setting.range = range;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set global(bool value) {
    _setting.global = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set goal(bool value) {
    _setting.goal = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set red(bool value) {
    _setting.red = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set yellow(bool value) {
    _setting.yellow = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set start(bool value) {
    _setting.start = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set end(bool value) {
    _setting.end = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set overlay(bool value) {
    _setting.overlay = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set vibrate(bool value) {
    _setting.vibrate = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }

  set sound(bool value) {
    _setting.sound = value ? 1 : 0;
    update();
    Storage().putObject(settingKey, _setting);
  }
}
