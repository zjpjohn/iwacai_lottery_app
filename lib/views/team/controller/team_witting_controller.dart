import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/team_witting.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';

class TeamWittingController extends BasePageQueryController {
  ///
  int page = 1, limit = 3, total = 0;
  List<TeamMatchWitting> wittings = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    await SportTeamRepository.teamMatchWittings(
      teamId: int.parse(Get.parameters['teamId']!),
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      wittings
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(wittings);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (total == wittings.length) {
      EasyLoading.showToast('没有更多情报');
      return;
    }
    page++;
    await SportTeamRepository.teamMatchWittings(
      teamId: int.parse(Get.parameters['teamId']!),
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      wittings.addAll(value.records);
      update();
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await SportTeamRepository.teamMatchWittings(
      teamId: int.parse(Get.parameters['teamId']!),
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      wittings
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(wittings);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
