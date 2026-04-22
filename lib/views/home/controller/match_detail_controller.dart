import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';

class MatchDetailController extends BaseRequestController {
  ///比赛详情
  late SportMatch match;

  void focusMatch() {
    if (match.focused == 0) {
      EasyLoading.show(status: '正在订阅');
      SportMatchRepository.focusMatch(match.matchId).then((value) {
        EasyLoading.showToast('订阅成功');
        match.focused = 1;
        update();
      }).whenComplete(() {
        Future.delayed(const Duration(microseconds: 250), () {
          EasyLoading.dismiss();
        });
      });
      return;
    }
    EasyLoading.show(status: '正在取消');
    SportMatchRepository.cancelFocus(match.matchId).then((value) {
      EasyLoading.showToast('取消成功');
      match.focused = 0;
      update();
    }).whenComplete(() {
      Future.delayed(const Duration(microseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  @override
  Future<void> request() async {
    showLoading();
    SportMatchRepository.matchDetail(int.parse(Get.parameters['matchId']!))
        .then((value) {
      match = value;
      Future.delayed(const Duration(milliseconds: 100), () {
        showSuccess(match);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  String matchState() {
    if (match.state.value == 0 ||
        match.state.value == 6 ||
        match.state.value == 5 ||
        match.state.value == 8) {
      return 'VS';
    }
    if (match.state.value == 11 ||
        match.state.value == 12 ||
        match.state.value == 14 ||
        match.state.value == 2) {
      return '${match.away.score}-${match.home.score}';
    }
    return '';
  }
}
