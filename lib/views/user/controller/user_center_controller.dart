import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/store/store.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';

class UserCenterController extends BasePageQueryController {
  @override
  Future<void> onInitial() async {
    state = RequestState.success;
    update();
    if (UserStore().authToken != '') {
      Future.delayed(const Duration(microseconds: 50), () {
        BalanceInstance().refreshBalance();
      });
    }
  }

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {
    BalanceInstance().refreshBalance();
  }
}
