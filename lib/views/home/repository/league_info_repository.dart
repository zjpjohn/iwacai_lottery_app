import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season_vo.dart';
import 'package:iwacai_lottery_app/views/base/model/search_result.dart';
import 'package:iwacai_lottery_app/views/base/model/season_cround.dart';
import 'package:iwacai_lottery_app/views/base/model/season_sround.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/home/model/league_date_info.dart';
import 'package:iwacai_lottery_app/views/home/model/match_filter_model.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';

///
///
class LeagueInfoRepository {
  ///
  /// 联赛详情
  ///
  static Future<LeagueInfo> leagueInfo(int leagueId) {
    return HttpRequest()
        .get('/ssport/app/league/$leagueId')
        .then((value) => LeagueInfo.fromJson(value.data));
  }

  ///
  /// 关注联赛
  ///
  static Future<void> focusLeague(int leagueId) {
    return HttpRequest()
        .post('/ssport/app/league/focus/$leagueId')
        .then((value) => null);
  }

  ///
  /// 取消关注联赛
  ///
  static Future<void> cancelFocus(int leagueId) {
    return HttpRequest()
        .delete('/ssport/app/league/focus/$leagueId')
        .then((value) => null);
  }

  ///
  /// 分页查询联赛关注列表
  ///
  static Future<PageResult<FocusLeague>> focusLeagueList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/app/league/focus/list', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (data) => FocusLeague.fromJson(data),
            ));
  }

  ///
  /// 查询联赛赛事日历
  ///
  static Future<List<LeagueDate>> getLeagueCalendar(
      {required DateTime dateTime, int? state}) {
    return HttpRequest().get('/ssport/share/league/date', params: {
      'state': state,
      'date': DateUtil.formatDate(dateTime, format: 'yyyy-MM-dd'),
    }).then((value) {
      List list = value.data ?? [];
      return list.map((e) => LeagueDate.fromJson(e)).toList();
    });
  }

  ///
  /// 按洲分组查询全部主流国家
  ///
  static Future<Map<int, List<CountryInfo>>> mainGroupCountries() {
    return HttpRequest().get('/ssport/share/country/main/group').then((value) {
      Map<dynamic, dynamic> data = value.data;
      return data.map((k, v) {
        List<CountryInfo> countries =
            (v as List).map((e) => CountryInfo.fromJson(e)).toList();
        return MapEntry(int.parse(k), countries);
      });
    });
  }

  ///
  /// 查询五大联赛信息
  ///
  static Future<List<LeagueInfo>> fiveLeagues() {
    return HttpRequest().get('/ssport/share/league/five').then((value) {
      List list = value.data;
      return list.map((e) => LeagueInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 主流国家过滤集合
  ///
  static Future<List<MatchFilter>> mainCountryFilters(DateTime date) {
    return HttpRequest().get(
      '/ssport/share/league/main',
      params: {'date': DateUtil.formatDate(date, format: "yyyy-MM-dd")},
    ).then((value) {
      return (value.data as List).map((e) => MatchFilter.fromJson(e)).toList();
    });
  }

  ///
  /// 查询区域主流赛事
  ///
  static Future<List<LeagueInfo>> areaMainLeagues(int area) {
    return HttpRequest().get('/ssport/share/league/main/$area').then((value) {
      List list = value.data;
      return list.map((e) => LeagueInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 分页查询联赛信息
  ///
  static Future<PageResult<LeagueInfo>> leagueList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/share/league/list', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (e) => LeagueInfo.fromJson(e),
            ));
  }

  ///
  /// 查询热门或主流联赛集合
  ///
  static Future<List<MatchFilter>> hotAndMainFiters() {
    return HttpRequest().get('/ssport/share/league/hot_main').then((value) {
      List list = value.data;
      return list.map((e) => MatchFilter.fromJson(e)).toList();
    });
  }

  ///
  ///查询热门联赛
  ///
  static Future<List<LeagueInfo>> hotLeagues() {
    return HttpRequest().get('/ssport/share/league/hot').then((value) {
      List list = value.data;
      return list.map((e) => LeagueInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询热门联赛
  ///
  static Future<List<LeagueInfo>> mainLeagues() {
    return HttpRequest().get('/ssport/share/league/main/list').then((value) {
      List list = value.data;
      return list.map((e) => LeagueInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询国家联赛集合
  ///
  static Future<List<LeagueInfo>> countryLeagues(int countryId) {
    return HttpRequest()
        .get('/ssport/share/league/country/$countryId/list')
        .then((value) {
      List list = value.data;
      return list.map((e) => LeagueInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 查询联赛赛季信息
  static Future<List<LeagueSeason>> leagueSeasons(int leagueId) {
    return HttpRequest()
        .get('/ssport/share/season/list/$leagueId')
        .then((value) {
      List list = value.data;
      return list.map((e) => LeagueSeason.fromJson(e)).toList();
    });
  }

  ///
  ///联赛赛季轮次集合
  static Future<List<SeasonSround>> seasonSrounds(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/season/sub-$seasonId/rounds')
        .then((value) {
      List list = value.data;
      return list.map((e) => SeasonSround.fromJson(e)).toList();
    });
  }

  ///
  ///杯赛赛季轮次集合
  static Future<List<SeasonCround>> seasonCrounds(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/season/cup-$seasonId/rounds')
        .then((value) {
      List list = value.data;
      return list.map((e) => SeasonCround.fromJson(e)).toList();
    });
  }

  ///
  /// 搜索
  static Future<Map<int, List<SearchResult>>> search(String query) {
    return HttpRequest().get(
      '/ssport/app/search/',
      params: {'query': query},
    ).then((value) {
      Map<String, dynamic> data = value.data;
      return data.map((key, value) {
        List list = value;
        return MapEntry(
          int.parse(key),
          list.map((e) => SearchResult.fromJson(e)).toList(),
        );
      });
    });
  }

  ///
  /// 查询最近赛事的联赛信息
  ///
  static Future<LeagueNearestInfo> nearestLeague({
    int? five,
    int? world,
    int? china,
  }) {
    return HttpRequest().get(
      '/ssport/app/league/nearest',
      params: {'five': five, 'world': world, 'china': china},
    ).then((value) => LeagueNearestInfo.fromJson(value.data));
  }

  ///
  /// 焦点联赛信息
  ///
  static Future<List<LeagueDate>> getCenterLeagues() {
    return HttpRequest().get('/ssport/share/league/center').then((value) {
      return (value.data as List).map((e) => LeagueDate.fromJson(e)).toList();
    });
  }

  ///
  /// 查询联赛最近比赛赛程
  ///
  static Future<LeagueSchedule> matchSchedule(int leagueId) {
    return HttpRequest().get(
      '/ssport/share/league/match/schedule',
      params: {'leagueId': leagueId},
    ).then((value) => LeagueSchedule.fromJson(value.data));
  }
}
