import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/news/model/channel_news.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class NewsCenterController extends GetxController {
  ///
  ///
  ChannelNews? channelNews;

  void loadChannelNews() {
    SportNewsRepository.channelTop().then((value) {
      channelNews = value;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    loadChannelNews();
  }
}
