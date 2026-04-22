import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_team.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';

class FocusTeamController extends BasePageQueryController {
  ///
  int total = 0, page = 1, limit = 10;
  List<FocusTeam> datas = [];

  Future<void> initLoad(bool showLoad) async {
    if (showLoad) {
      showLoading();
    }
    page = 1;
    await SportTeamRepository.focusTeamList({
      'page': page,
      'limit': limit,
    }).then((value) {
      total = value.total;
      datas
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(microseconds: 200), () {
        showSuccess(datas);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onInitial() async {
    await initLoad(true);
  }

  @override
  Future<void> onRefresh() async {
    await initLoad(false);
  }

  @override
  Future<void> onLoadMore() async {
    if (datas.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await SportTeamRepository.focusTeamList({
      'page': page,
      'limit': limit,
    }).then((value) {
      datas.addAll(value.records);
      update();
    }).catchError((error) {
      showError(error);
    });
  }
}
