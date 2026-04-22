import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_center_controller.dart';

class TeamScheduleController extends BasePageQueryController {
  ///
  late TeamSeasonMatchQuery query;
  int total = 0;
  List<SportMatch> matches = [];

  set type(int type) {
    if (query.type != type) {
      query.type = type;
      onInitial();
    }
  }

  int get type => query.type;

  set matchState(int value) {
    if (query.state != value) {
      query.state = value;
      onInitial();
    }
  }

  int get matchState => query.state;

  @override
  void onInit() {
    query = TeamSeasonMatchQuery(teamId: int.parse(Get.parameters['teamId']!));
    super.onInit();
  }

  bool setSeason() {
    TeamCenterController teamController = Get.find<TeamCenterController>();
    if (teamController.season == null) {
      return false;
    }
    query.page = 1;
    query.seasonId = teamController.season!.id;
    return true;
  }

  @override
  Future<void> onInitial() async {
    if (!setSeason()) {
      matches.clear();
      total = 0;
      state = RequestState.empty;
      update();
      return;
    }
    showLoading();
    await SportMatchRepository.teamMatches(query.toJson()).then((value) {
      total = value.total;
      matches
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(matches);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (total == matches.length) {
      EasyLoading.showToast('没有更多赛事');
      return;
    }
    query.page = query.page + 1;
    await SportMatchRepository.teamMatches(query.toJson()).then((value) {
      total = value.total;
      matches.addAll(value.records);
      update();
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    query.page = 1;
    await SportMatchRepository.teamMatches(query.toJson()).then((value) {
      total = value.total;
      matches
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(matches);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

class TeamSeasonMatchQuery {
  late int teamId;
  late int type;
  late int seasonId;
  late int state;
  late int page;
  late int limit;

  TeamSeasonMatchQuery({
    required this.teamId,
    this.seasonId = -1,
    this.type = 0,
    this.state = 2,
    this.page = 1,
    this.limit = 15,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['teamId'] = teamId;
    json['seasonId'] = seasonId;
    json['type'] = type;
    json['state'] = state;
    json['page'] = page;
    json['limit'] = limit;
    return json;
  }
}
