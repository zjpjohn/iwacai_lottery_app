import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/store/store.dart';
import 'package:iwacai_lottery_app/views/base/model/search_result.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/match_filter_model.dart';
import 'package:iwacai_lottery_app/views/home/repository/league_info_repository.dart';

class LeagueSearchController extends BaseRequestController {
  ///热门联赛过滤
  List<MatchFilter> hotList = [];

  ///主流联赛过滤
  List<MatchFilter> mainList = [];

  ///搜索历史
  List<SearchResult> histories = [];
  String _search = '';
  bool _showSearch = false;

  ///搜索结果
  Map<int, List<SearchResult>> results = {};

  String get search => _search;

  bool get showSearch => _showSearch;

  set showSearch(bool value) {
    _showSearch = value;
    update();
  }

  set search(String value) {
    _search = value;
    update();
    if (_search.isEmpty) {
      showSearch = false;
    }
  }

  void searchAction() {
    if (_search.isEmpty) {
      results.clear();
      update();
      return;
    }
    showSearch = true;
    EasyLoading.show(status: '搜索中');
    LeagueInfoRepository.search(_search)
        .then((value) {
          results
            ..clear()
            ..addAll(value);
          update();
        })
        .catchError((error) {})
        .whenComplete(() {
          Future.delayed(
            const Duration(milliseconds: 250),
            () => EasyLoading.dismiss(),
          );
        });
  }

  ///清空搜索历史
  void clearHistory() {
    histories.clear();
    ConfigStore().histories = null;
    update();
  }

  ///
  /// 跳转搜索内容详情页
  void gotoSearchDetail(SearchResult result, {bool history = false}) {
    if (history &&
        !histories.any((e) => e.id == result.id && e.type == result.type)) {
      histories = [result, ...histories];
      ConfigStore().histories = [
        json.encode(result.toJson()),
        ...ConfigStore().histories
      ];
      update();
    }
    if (result.type == 0) {
      Get.toNamed('/league/${result.id}');
      return;
    }
    Get.toNamed('/team/${result.relateId}/${result.id}');
  }

  void hotAndMainFilters() {
    LeagueInfoRepository.hotAndMainFiters().then((value) {
      hotList = value.where((e) => e.type == 1).toList();
      mainList = value.where((e) => e.type == 2).toList();
      update();
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> request() async {
    Future.delayed(const Duration(milliseconds: 250), () {
      showSuccess(true);
    });
  }

  @override
  void onInit() {
    super.onInit();
    histories = ConfigStore()
        .histories
        .map((e) => SearchResult.fromJson(json.decode(e)))
        .toList();
    hotAndMainFilters();
  }
}
