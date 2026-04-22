import 'package:iwacai_lottery_app/views/base/request_controller.dart';

class UserRightsController extends BaseRequestController {
  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 250), () {
      showSuccess(true);
    });
  }
}
