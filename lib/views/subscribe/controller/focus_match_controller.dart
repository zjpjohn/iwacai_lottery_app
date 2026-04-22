import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';

class FocusMatchController extends BasePageQueryController {
  ///
  int total = 0, page = 1, limit = 10;
  List<SportMatch> matches = [];

  ///
  /// 取消订阅
  void cancelFocus(SportMatch match) {
    SportMatchRepository.cancelFocus(match.matchId).then((value) {
      total = total - 1;
      matches.removeWhere((e) => e.matchId == match.matchId);
      update();
      if (matches.isEmpty) {
        initialLoad(true);
      }
    }).catchError((error) {
      EasyLoading.showError('取消订阅失败');
    });
  }

  void initialLoad(bool showLoad) async {
    if (showLoad) {
      showLoading();
    }
    page = 1;
    await SportMatchRepository.focusMatchList({
      'page': page,
      'limit': limit,
    }).then((value) {
      total = value.total;
      matches
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(matches);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onInitial() async {
    initialLoad(true);
  }

  @override
  Future<void> onRefresh() async {
    initialLoad(false);
  }

  @override
  Future<void> onLoadMore() async {
    if (total == matches.length) {
      EasyLoading.showToast('没有更多赛事');
      return;
    }
    page++;
    await SportMatchRepository.focusMatchList({
      'page': page,
      'limit': limit,
    }).then((value) {
      total = value.total;
      matches.addAll(value.records);
      update();
    }).catchError((error) {
      showError(error);
    });
  }
}
