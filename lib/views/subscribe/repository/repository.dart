import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';

class UserSubscribeRepository {
  ///
  /// 获取用户关注的专家列表
  ///
 static Future<PageResult<ExpertScheme>> getFocusExperts(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/scheme/focus/experts', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (data) => ExpertScheme.fromJson(data),
            ));
  }
}
