import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season_vo.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';
import 'package:iwacai_lottery_app/views/news/model/sport_news.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class NewsFiveController extends BasePageQueryController {
  ///
  ///
  int total = 0, page = 1, limit = 10;
  List<SportNews> newsList = [];

  ///
  ///
  List<SportMatch> matches = [];

  ///
  ///
  late LeagueNearestInfo league;

  List<Future<void>> asyncFutures() {
    return [
      LeagueInfoRepository.nearestLeague(five: 1)
          .then((value) => league = value),
      SportMatchRepository.hotMatches({'five': 1})
          .then((value) => matches = value),
      SportNewsRepository.getNewsList({
        'five': 1,
        'page': page,
        'limit': limit,
      }).then((value) {
        total = value.total;
        newsList
          ..clear()
          ..addAll(value.records);
      }),
    ];
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await Future.wait(asyncFutures()).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (newsList.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await SportNewsRepository.getNewsList({
      'five': 1,
      'page': page,
      'limit': limit,
    }).then((value) {
      total = value.total;
      newsList.addAll(value.records);
      update();
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await Future.wait(asyncFutures()).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
