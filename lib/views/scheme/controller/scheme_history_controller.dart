import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';
import 'package:iwacai_lottery_app/views/scheme/repository/expert_scheme_repository.dart';

class SchemeHistoryController extends BasePageQueryController {
  ///
  /// 专家标识
  String expertNo = Get.parameters['expertNo']!;

  ///
  int page = 1, limit = 10, total = 0;

  ///
  List<ExpertScheme> datas = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await ExpertSchemeRepository.getHistorySchemes({
      'page': page,
      'limit': limit,
      'expertNo': expertNo,
    }).then((value) {
      datas
        ..clear()
        ..addAll(value.records);
      total = value.total;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(datas);
      });
    }).catchError((error) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showError(error);
      });
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (datas.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await ExpertSchemeRepository.getHistorySchemes({
      'page': page,
      'limit': limit,
      'expertNo': expertNo,
    }).then((value) {
      datas.addAll(value.records);
      update();
    }).catchError((error) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showError(error);
      });
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await ExpertSchemeRepository.getHistorySchemes({
      'page': page,
      'limit': limit,
      'expertNo': expertNo,
    }).then((value) {
      datas
        ..clear()
        ..addAll(value.records);
      total = value.total;
      update();
    }).catchError((error) {
      showError(error);
    });
  }
}
