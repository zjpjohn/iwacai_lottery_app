import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/feedback/index.dart';

class FeedbackRepository {
  ///
  /// 提交反馈信息
  ///
 static Future<void> submitFeedback(FeedbackInfo feedback) async {
    return HttpRequest()
        .postJson('/ucenter/app/feedback/', data: feedback.toJson())
        .then((value) => null);
  }
}
