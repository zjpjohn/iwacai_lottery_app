import 'dart:async';

import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/home/model/league_date_info.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';
import 'package:iwacai_lottery_app/views/means/model/area_info.dart';

class AreaModel {
  ///
  /// 区域标识
  late int area;

  ///
  /// 区域国家集合
  List<CountryInfo> countries = [];

  ///
  /// 区域主流赛事
  List<LeagueInfo> main = [];

  ///
  /// 国家赛事集合
  Map<int, List<LeagueInfo>> leagues = {};

  AreaModel({required this.area});

  void setLeagues(int country, List<LeagueInfo> values) {
    leagues[country] = values;
  }

  List<LeagueInfo>? getLeagues(int countryId) {
    return leagues[countryId];
  }
}

class LeagueCenterController extends BasePageQueryController {
  ///
  ///
  List<LeagueDate> leagueDate = [];
  List<LeagueInfo> leagues = [];

  ///
  /// 区域标识
  int _area = 1;

  /// 国家列表标识
  int _index = 0;

  ///
  bool areaLoad = false;

  ///
  List<AreaInfo> areas = [
    AreaInfo(code: 1, name: '欧洲', nameEn: 'EUROPE'),
    AreaInfo(code: 2, name: '美洲', nameEn: 'AMERICA'),
    AreaInfo(code: 3, name: '亚洲', nameEn: 'ASIA'),
    AreaInfo(code: 5, name: '非洲', nameEn: 'AFRICA'),
    AreaInfo(code: 4, name: '大洋洲', nameEn: 'OCEANIA'),
  ];

  ///
  Map<int, AreaModel> areaModels = {
    1: AreaModel(area: 1),
    2: AreaModel(area: 2),
    3: AreaModel(area: 3),
    5: AreaModel(area: 5),
    4: AreaModel(area: 4),
  };

  ///
  bool _showMore = false;

  bool get showMore => _showMore;

  set showMore(bool value) {
    _showMore = value;
    update();
  }

  set area(int area) {
    set(area, 0);
  }

  int get area => _area;

  set index(int index) {
    set(_area, index);
  }

  int get index => _index;

  AreaModel areaModel() {
    return areaModels[_area]!;
  }

  void toMore() {
    Get.toNamed('/area/$_area');
  }

  ///
  /// 切换指定标识的联赛信息
  void set(int area, int index) {
    ///
    ///相同标识直接跳过
    if (_area == area && _index == index) {
      return;
    }

    ///设置更新标识
    _area = area;
    _index = index;
    update();

    ///加载数据
    _areaAsync();
  }

  Future<void> _areaAsync() async {
    /// 非大洋洲区域
    AreaModel areaModel = areaModels[_area]!;
    if (_area == 4) {
      CountryInfo country = areaModel.countries[_index];
      if (areaModel.leagues[country.id] == null) {
        areaLoad = true;
        LeagueInfoRepository.countryLeagues(country.id).then((value) {
          areaModel.leagues[country.id] = value;
        }).whenComplete(() {
          areaLoad = false;
          update();
        });
      }
      return;
    }
    if (_index == 0) {
      if (areaModel.main.isEmpty) {
        areaLoad = true;
        LeagueInfoRepository.areaMainLeagues(_area).then((value) {
          areaModel.main = value;
        }).whenComplete(() {
          areaLoad = false;
          update();
        });
      }
      return;
    }
    CountryInfo country = areaModel.countries[_index - 1];
    if (areaModel.leagues[country.id] == null) {
      areaLoad = true;
      LeagueInfoRepository.countryLeagues(country.id).then((value) {
        areaModel.leagues[country.id] = value;
      }).whenComplete(() {
        areaLoad = false;
        update();
      });
    }
  }

  ///
  /// 指定标识的联赛信息
  List<LeagueInfo> areaLeague() {
    AreaModel areaModel = areaModels[_area]!;
    if (_area == 4) {
      CountryInfo country = areaModel.countries[_index];
      return areaModel.leagues[country.id] ?? [];
    }
    if (_index == 0) {
      return areaModel.main;
    }
    CountryInfo country = areaModel.countries[_index - 1];
    return areaModel.leagues[country.id] ?? [];
  }

  ///
  /// 指定区域的国家集合
  List<CountryInfo> areaCountry() {
    AreaModel areaModel = areaModels[_area]!;
    return areaModel.countries;
  }

  @override
  Future<void> onInitial() async {
    showLoading();

    Future<void> countryAsync =
        LeagueInfoRepository.mainGroupCountries().then((value) {
      value.forEach((key, value) {
        areaModels[key]!.countries = value;
      });
    });

    ///
    Future<void> dateFuture =
        LeagueInfoRepository.getLeagueCalendar(dateTime: DateTime.now())
            .then((value) {
      leagueDate
        ..clear()
        ..addAll(value);
      showMore = leagueDate.length > 12;
    });

    ///
    Future<void> leagueFuture = LeagueInfoRepository.hotLeagues().then((value) {
      leagues
        ..clear()
        ..addAll(value);
    });
    await Future.wait([
      countryAsync,
      dateFuture,
      leagueFuture,
      _areaAsync(),
    ]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        state = RequestState.success;
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
    ///
    Future<void> dateFuture =
        LeagueInfoRepository.getLeagueCalendar(dateTime: DateTime.now())
            .then((value) {
      leagueDate
        ..clear()
        ..addAll(value);
    });

    ///
    Future<void> leagueFuture = LeagueInfoRepository.hotLeagues().then((value) {
      leagues
        ..clear()
        ..addAll(value);
    });
    await Future.wait([dateFuture, leagueFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
