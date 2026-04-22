import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/sport_news.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class NewsDetailController extends BaseRequestController {
  ///
  ///新闻内容
  late SportNews news;

  ///
  ///新闻标识
  late int newsId;

  ///
  ///点赞新闻
  void praiseNews() async {
    if (news.praised == 1) {
      EasyLoading.showToast('已点赞');
      return;
    }
    EasyLoading.show();
    await SportNewsRepository.praiseNews(newsId).then((_) {
      news.praised = 1;
      news.votes = news.votes + 1;
      update();
      EasyLoading.showToast('点赞成功');
    }).catchError((error) {
      EasyLoading.showToast('点赞失败');
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 350), () {
        EasyLoading.dismiss();
      });
    });
  }

  ///
  /// 数据请求
  ///
  @override
  Future<void> request() async {
    newsId = int.parse(Get.parameters['newsId']!);
    SportNewsRepository.sportNews(newsId).then((value) {
      news = value;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(value);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
