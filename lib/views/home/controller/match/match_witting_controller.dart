import 'package:collection/collection.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/team_witting.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_team_repository.dart';

class MatchWittingController extends BasePageQueryController {
  ///
  ///
  final int matchId;

  MatchWittingController(this.matchId);

  ///
  ///主客队情报信息
  List<TeamWitting> homeWitting = [];
  List<TeamWitting> awayWitting = [];

  Map<String, List<TeamWitting>> groupWitting(List<TeamWitting> wittings) {
    if (wittings.isEmpty) {
      return {};
    }
    return groupBy(
      wittings,
      (value) {
        DateTime gmtCreate = DateUtil.parse(
          value.gmtCreate,
          pattern: "yyyy/MM/dd HH:mm:ss",
        );
        return DateUtil.formatDate(gmtCreate, format: "yyyy-MM-dd");
      },
    );
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    SportTeamRepository.matchTeamWitting(matchId).then((value) {
      homeWitting
        ..clear()
        ..addAll(value[1]!);
      awayWitting
        ..clear()
        ..addAll(value[0]!);
      state = homeWitting.isNotEmpty || awayWitting.isNotEmpty
          ? RequestState.success
          : RequestState.empty;
      update();
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {
    SportTeamRepository.matchTeamWitting(matchId).then((value) {
      homeWitting
        ..clear()
        ..addAll(value[1]!);
      awayWitting
        ..clear()
        ..addAll(value[0]!);
      state = homeWitting.isNotEmpty || awayWitting.isNotEmpty
          ? RequestState.success
          : RequestState.empty;
      update();
    }).catchError((error) {
      showError(error);
    });
  }
}
