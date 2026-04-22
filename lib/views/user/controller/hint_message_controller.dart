import 'package:iwacai_lottery_app/views/base/request_controller.dart';

class HintMessageController extends BaseRequestController {
  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 250), () {
      showSuccess(null);
    });
  }
}
