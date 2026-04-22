import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/billboard_news.dart';
import 'package:iwacai_lottery_app/views/news/model/news_topic.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class NewsBillboardController extends BaseRequestController {
  ///
  ///
  List<BillboardNews> newsList = [];

  ///
  /// 热门话题集合
  List<SportNewsTopic> topicList = [];

  List<Future<void>> asyncFutures() {
    return [
      SportNewsRepository.hotTopicList().then((value) => topicList = value),
      SportNewsRepository.billboardNewsList().then((value) => newsList = value),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncFutures()).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
