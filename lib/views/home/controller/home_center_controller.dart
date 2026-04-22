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

///
/// 接管页面刷新组件状态，防止页面全局刷新
///
enum HomePageState {
  ///加载中
  loading,

  /// 加载成功
  success,

  /// 加载失败
  error,
}

class HomeCenterController extends BasePageQueryController {
  ///
  /// 焦点联赛集合
  List<LeagueDate> centerLeagues = [];

  /// 热门比赛集合
  List<SportMatch> hotMatches = [];

  ///
  ///联赛赛事日历
  List<LeagueDate> leagues = [];

  ///
  /// 主流国家集合
  List<MatchFilter> mainCountries = [];

  ///
  /// 主流联赛集合
  List<MatchFilter> mainLeagues = [];

  ///
  /// 首页加载状态
  HomePageState pageState = HomePageState.loading;

  ///
  ///当前时间
  DateTime current = DateTime.now();

  ///
  /// 是否选择今日赛事
  bool? dateLeague;

  ///
  /// 查询条件
  late DateMatchQuery query;

  ///
  /// 赛事数据
  int total = 0, limit = 20;
  List<SportMatch> matches = [];

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
    refreshController.callRefresh(
      duration: const Duration(milliseconds: 200),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.back();
    });
  }

  set date(DateTime date) {
    ///默认查询全部赛程(包括结束、未开始、正在进行的)
    query.state = null;
    if (date.isAfter(current)) {
      query.state = 1;
    }
    query.date = date;
    dateLeague = null;
    query.stageId = null;
    query.leagueId = null;
    query.countryId = null;
    update();

    if (pageState == HomePageState.error) {
      onInitial();
      return;
    }

    refreshController.callRefresh(duration: const Duration(milliseconds: 200));
    matchFilterAsync();
  }

  DateTime get date => query.date;

  void matchFilterAsync() async {
    Future<void> leagueCalendarAsync = LeagueInfoRepository.getLeagueCalendar(
      dateTime: query.date,
      state: 1,
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
    try {
      await Future.wait([
        leagueCalendarAsync,
        mainLeagueAsync,
        mainCountryAsync,
      ]);
    } catch (_) {}
  }

  void sortMatches(List<SportMatch> loaded) {
    DateTime time = DateTime.now()..add(const Duration(minutes: -120));

    List<SportMatch> allMatches = [...matches, ...loaded];
    List<SportMatch> doingMatches = allMatches
        .where((e) => e.isDoing())
        .toList()
      ..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate));
    List<SportMatch> unStartMatches = allMatches
        .where((e) => e.isUnStart())
        .toList()
      ..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate));

    ///过去未开始比赛
    List<SportMatch> pastUnStartMatches =
        unStartMatches.where((e) => e.vsDateTime.compareTo(time) <= 0).toList();

    ///未来未开始比赛
    List<SportMatch> futureUnStartMatches =
        unStartMatches.where((e) => e.vsDateTime.compareTo(time) > 0).toList();

    ///已完场比赛
    List<SportMatch> completedMatches = allMatches
        .where((e) => e.isCompleted())
        .toList()
      ..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate));

    ///已取消比赛
    List<SportMatch> canceledMatches = allMatches
        .where((e) => e.isCanceled())
        .toList()
      ..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate));

    ///未知状态比赛
    List<SportMatch> unknownMatches = allMatches
        .where((e) => e.isUnknown())
        .toList()
      ..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate));
    matches
      ..clear()
      ..addAll(doingMatches)
      ..addAll(futureUnStartMatches)
      ..addAll(pastUnStartMatches)
      ..addAll(completedMatches)
      ..addAll(canceledMatches)
      ..addAll(unknownMatches);
  }

  Future<void> refreshLoadMatches() async {
    query.page = 1;
    await SportMatchRepository.getDateSportMatches(query.toJson())
        .then((value) {
      total = value.total;
      if (query.date.day == current.day) {
        matches.clear();
        sortMatches(value.records);
      } else {
        matches
          ..clear()
          ..addAll(
              value.records..sort((m1, m2) => m1.vsDate.compareTo(m2.vsDate)));
      }
    });
  }

  @override
  Future<void> onInitial() async {
    pageState = HomePageState.loading;
    update();
    Future<void> matchLoadAsync = refreshLoadMatches();
    Future<void> leagueAsync =
        LeagueInfoRepository.getCenterLeagues().then((value) {
      centerLeagues = value;
    });
    Future<void> hotMatchAsync =
        SportMatchRepository.hotMatchList().then((value) => hotMatches = value);
    Future.wait([leagueAsync, hotMatchAsync, matchLoadAsync]).then((value) {
      pageState = HomePageState.success;
    }).catchError((error) {
      pageState = HomePageState.error;
    }).whenComplete(() {
      ///保证刷新组件状态一定为成功，防止页面整体刷新
      state = RequestState.success;
      Future.delayed(const Duration(milliseconds: 50), () {
        update();
      });
    });
    matchFilterAsync();
  }

  @override
  Future<void> onLoadMore() async {
    if (matches.length == total) {
      return;
    }
    query.page++;
    SportMatchRepository.getDateSportMatches(query.toJson()).then((value) {
      total = value.total;
      sortMatches(value.records);
    }).catchError((error) {
      query.page--;
      pageState = HomePageState.error;
    }).whenComplete(() => update());
  }

  @override
  Future<void> onRefresh() async {
    await refreshLoadMatches().catchError((error) {
      pageState = HomePageState.error;
    }).whenComplete(() => update());
  }

  @override
  void onInit() {
    query = DateMatchQuery(date: current, limit: limit);
    super.onInit();
  }
}
