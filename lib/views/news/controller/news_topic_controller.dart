import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/news/model/news_topic.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class NewsTopicController extends BasePageQueryController {
  ///
  ///
  late int topicId;
  late SportNewsTopic topic;

  ///
  int page = 1, limit = 10, total = 10;
  List<TopicNewsItem> list = [];

  ///
  ///
  List<Future<void>> asyncFutures() {
    return [
      SportNewsRepository.newsTopic(topicId).then((value) => topic = value),
      SportNewsRepository.topicNewsList({
        'page': page,
        'limit': limit,
        'topicId': topicId,
      }).then((value) {
        total = value.total;
        list
          ..clear()
          ..addAll(value.records);
      }),
    ];
  }

  @override
  Future<void> onInitial() async {
    topicId = int.parse(Get.parameters['topicId']!);
    page = 1;
    showLoading();
    await Future.wait(asyncFutures()).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(list);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (list.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await SportNewsRepository.topicNewsList({
      'page': page,
      'limit': limit,
      'topicId': topicId,
    }).then((value) {
      total = value.total;
      list.addAll(value.records);
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
