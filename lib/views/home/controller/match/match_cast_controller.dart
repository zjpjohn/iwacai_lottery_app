import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/model/match_census.dart';
import 'package:iwacai_lottery_app/views/base/model/match_event.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';

const Map<String, String> typeResources = {
  '进球': R.jinqiu,
  '点球': R.dianqiu,
  '乌龙': R.wulong,
  '换人': R.huanren,
  '黄牌': R.ycard,
  '红牌': R.rcard,
};

class MatchCastController extends BasePageQueryController {
  ///
  ///
  final int matchId;

  MatchCastController(this.matchId);

  ///
  List<MatchEvent> events = [];
  MatchCensus? census;

  bool _expanded = false;

  bool get expanded => _expanded;

  set expanded(bool expanded) {
    _expanded = expanded;
    update();
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    Future<void> eventFuture =
        SportMatchRepository.matchEvents(matchId).then((value) {
      events
        ..clear()
        ..addAll(value);
    });
    Future<void> censusFuture =
        SportMatchRepository.matchCensus(matchId).then((value) {
      census = value;
    });

    await Future.wait([eventFuture, censusFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        state = events.isNotEmpty || census != null
            ? RequestState.success
            : RequestState.empty;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {
    Future<void> eventFuture =
        SportMatchRepository.matchEvents(matchId).then((value) {
      events
        ..clear()
        ..addAll(value);
    });
    Future<void> censusFuture =
        SportMatchRepository.matchCensus(matchId).then((value) {
      census = value;
    });

    await Future.wait([eventFuture, censusFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        state = events.isNotEmpty || census != null
            ? RequestState.success
            : RequestState.empty;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
