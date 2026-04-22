import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/model/date_match_query.dart';
import 'package:iwacai_lottery_app/views/home/model/league_date_info.dart';
import 'package:iwacai_lottery_app/views/home/model/match_filter_model.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/country_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';
import 'package:iwacai_lottery_app/views/home/repository/sport_match_repository.dart';

class MatchResultController extends BasePageQueryController {
  ///
  /// 今日比赛联赛集合
  List<LeagueDate> leagues = [];

  ///
  /// 主流国家集合
  List<MatchFilter> mainCountries = [];

  ///
  /// 主流联赛集合
  List<MatchFilter> mainLeagues = [];

  ///
  /// 是否选择今日赛事
  bool? dateLeague;

  ///
  /// 查询条件
  late DateMatchQuery query;

  ///
  int total = 0, limit = 12;
  List<SportMatch> matches = [];
  DateTime current = DateTime.now();

  void setDateFilter(int leagueId) {
    query.countryId = null;
    if (dateLeague ?? false) {
      if (query.leagueId == leagueId) {
        dateLeague = null;
        query.leagueId = null;
      } else {
        query.leagueId = leagueId;
      }
    } else {
      dateLeague = true;
      query.leagueId = leagueId;
    }
    update();
    refreshController.callRefresh(duration: const Duration(milliseconds: 200));
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.back();
    });
  }

  void setMainFilter(int leagueId) {
    query.countryId = null;
    if (dateLeague != null && dateLeague!) {
      dateLeague = null;
      query.leagueId = leagueId;
    } else if (query.leagueId == leagueId) {
      query.leagueId = null;
    } else {
      query.leagueId = leagueId;
    }
    update();
    refreshController.callRefresh(duration: const Duration(milliseconds: 200));
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.back();
    });
  }

  void setCountryFilter(int country) {
    dateLeague = null;
    query.leagueId = null;
    if (query.countryId == country) {
      query.countryId = null;
    } else {
      query.countryId = country;
    }
    update();
    refreshController.callRefresh(duration: const Duration(milliseconds: 200));
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.back();
    });
  }

  set date(DateTime date) {
    dateLeague = null;
    query.date = date;
    query.stageId = null;
    query.leagueId = null;
    query.countryId = null;
    update();
    if (state == RequestState.empty || state == RequestState.error) {
      onInitial();
      return;
    }
    refreshController.callRefresh(duration: const Duration(milliseconds: 200));
    matchFilterAsync();
  }

  DateTime get date => query.date;

  Future<void> refreshMatches() async {
    query.page = 1;
    await SportMatchRepository.getDateSportMatches(query.toJson())
        .then((value) {
      total = value.total;
      matches
        ..clear()
        ..addAll(
            value.records..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate)));
      showSuccess(matches);
    });
  }

  void matchFilterAsync() async {
    Future<void> leagueCalendarAsync = LeagueInfoRepository.getLeagueCalendar(
      dateTime: query.date,
      state: 0,
    ).then((value) {
      leagues = value;
    });
    Future<void> mainLeagueAsync =
        LeagueInfoRepository.mainCountryFilters(query.date).then((value) {
      mainLeagues = value;
    });
    Future<void> mainCountryAsync =
        CountryInfoRepository.mainCountryFilters(query.date).then((value) {
      mainCountries = value;
    });
    await Future.wait([
      leagueCalendarAsync,
      mainLeagueAsync,
      mainCountryAsync,
    ]).whenComplete(() => update());
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    matchFilterAsync();
    refreshMatches().catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (matches.length == total) {
      return;
    }
    query.page++;
    SportMatchRepository.getDateSportMatches(query.toJson()).then((value) {
      total = value.total;
      total = value.total;
      matches.addAll(
          value.records..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate)));
      update();
    }).catchError((error) {
      query.page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    refreshMatches().catchError((error) => showError(error));
  }

  @override
  void onInit() {
    query = DateMatchQuery(date: current, state: 0);
    super.onInit();
  }
}
