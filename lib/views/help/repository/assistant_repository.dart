import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/help/model/app_assistant.dart';

///
///
///
class AssistantRepository {
  ///
  ///查询应用助手信息
  static Future<List<AppAssistant>> appAssistants({
    required String appNo,
    required String version,
  }) {
    return HttpRequest().get('/lope/app/assistant/list', params: {
      'appNo': appNo,
      'version': version,
      'detail': true,
    }).then((value) {
      List result = value.data;
      return result.map((e) => AppAssistant.fromJson(e)).toList();
    });
  }

}
