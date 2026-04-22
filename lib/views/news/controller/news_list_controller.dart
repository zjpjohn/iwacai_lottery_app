import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/sport_news.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class NewsRequestController extends BasePageQueryController {
  ///
  /// 数据总数
  int total = 0;

  ///
  ///
  List<SportNews> data = [];

  ///
  /// 分页查询条件
  NewsPageQuery query = NewsPageQuery();

  void setQueryTag(String? tag) {
    query.tag = tag;
    update();
    refreshController.callRefresh(duration: const Duration(milliseconds: 200));
    Future.delayed(const Duration(milliseconds: 200), () => refreshData());
  }

  Future<void> refreshData() async {
    query.page = 1;
    await SportNewsRepository.getNewsList(query.toJson()).then((value) {
      data
        ..clear()
        ..addAll(value.records);
      total = value.total;
    });
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await refreshData().then((value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(data);
      });
    }).catchError((error) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showError(error);
      });
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (data.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    query.page++;
    await SportNewsRepository.getNewsList(query.toJson()).then((value) {
      data.addAll(value.records);
      update();
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    query.page = 1;
    await SportNewsRepository.getNewsList(query.toJson()).then((value) {
      total = value.total;
      data
        ..clear()
        ..addAll(value.records);
      showSuccess(data);
    }).catchError((error) {
      showError(error);
    });
  }
}

class NewsTag {
  ///
  /// 标签名称
  String label;

  ///
  /// 标签条件
  String? tag;

  NewsTag(this.label, this.tag);
}

///
/// 新闻资讯查询条件
///
class NewsPageQuery {
  ///
  /// 标签
  String? tag;

  ///
  /// 分页页码
  int page = 1;

  ///
  /// 每页数据量
  int limit = 10;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tag'] = tag;
    json['page'] = page;
    json['limit'] = limit;
    return json;
  }
}
