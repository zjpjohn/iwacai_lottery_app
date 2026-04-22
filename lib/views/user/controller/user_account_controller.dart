import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';

class UserAccountController extends BaseRequestController {
  @override
  Future<void> request() async {
    showLoading();
    BalanceInstance().refreshBalance();
    Future.delayed(const Duration(milliseconds: 300), () {
      showSuccess(true);
    });
  }
}
