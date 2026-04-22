import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_browse.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_browse_repository.dart';

class BrowseRecordController extends BasePageQueryController {
  ///
  int page = 1, limit = 12, total = 0;
  List<SportBrowseRecord> records = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await SportBrowseRepository.browseList(
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
    if (total == records.length) {
      EasyLoading.showToast('没有更多记录');
      return;
    }
    page = page + 1;
    await SportBrowseRepository.browseList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records.addAll(value.records);
      update();
    }).catchError((error) {
      page = page - 1;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await SportBrowseRepository.browseList(
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
