
import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
class UserAgentRule {
  late EnumValue agent;
  late int profited;
  late double ratio;
  late int reward;
  late String startTime;

  UserAgentRule.fromJson(Map<String, dynamic> json) {
    agent = EnumValue.fromJson(json['agent']);
    profited = json['profited'];
    ratio = json['ratio'];
    reward = json['reward'];
    startTime = json['startTime'];
  }
}

///
class AgentRuleHint {
  ///变更提醒内容
  late String content;

  ///规则启用时间
  late String startTime;

  AgentRuleHint.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    startTime = json['startTime'];
  }
}
