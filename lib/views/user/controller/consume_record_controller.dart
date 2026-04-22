import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/user/model/balance_log.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';

class ConsumerRecordController extends BasePageQueryController {
  ///
  int page = 1, limit = 10, total = 0;
  List<BalanceLog> records = [];

  @override
  bool loadedAll() {
    return total > 0 && records.length == total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await UserInfoRepository.consumeRecords(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(records);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (records.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await UserInfoRepository.consumeRecords(
      page: page,
      limit: limit,
    ).then((value) {
      records.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
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
    await UserInfoRepository.consumeRecords(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(records);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
