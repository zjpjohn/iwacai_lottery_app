import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';
import 'package:iwacai_lottery_app/views/scheme/repository/expert_scheme_repository.dart';

class SchemeListController extends BasePageQueryController {
  ///
  int total = 0, page = 1, limit = 8;
  List<ExpertScheme> datas = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    ExpertSchemeRepository.getExpSchemeList({'page': page, 'limit': limit})
        .then((value) {
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
    ExpertSchemeRepository.getExpSchemeList({'page': page, 'limit': limit})
        .then((value) {
      datas.addAll(value.records);
      update();
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    ExpertSchemeRepository.getExpSchemeList({'page': page, 'limit': limit})
        .then((value) {
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
