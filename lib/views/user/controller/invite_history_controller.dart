import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/user/model/user_info.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';

class InviteHistoryController extends BasePageQueryController {
  ///
  ///
  int page = 1, limit = 10, total = 0;
  List<UserInfo> histories = [];

  @override
  bool loadedAll() {
    return total > 0 && histories.length == total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await UserInfoRepository.inviteUsers(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      histories
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(histories);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    await UserInfoRepository.inviteUsers(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      histories.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await UserInfoRepository.inviteUsers(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      histories
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(histories);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
