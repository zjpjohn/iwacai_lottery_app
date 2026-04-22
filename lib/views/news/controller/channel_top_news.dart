import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/news/model/channel_news.dart';
import 'package:iwacai_lottery_app/views/news/repository/sport_news_repository.dart';

class ChannelTopNews extends GetxController {
  ///
  ///
  static ChannelTopNews? _instance;

  factory ChannelTopNews() {
    ChannelTopNews._instance ??=
        Get.put<ChannelTopNews>(ChannelTopNews._initialize());
    return ChannelTopNews._instance!;
  }

  ChannelTopNews._initialize();

  ChannelNews? _news;

  Future<void> loadTopNews() async {
    await SportNewsRepository.channelTop().then((value) {
      news = value;
    });
  }

  set news(ChannelNews? news) {
    _news = news;
    update();
  }

  ChannelNews? get news => _news;

  @override
  void onInit() {
    super.onInit();
    loadTopNews().catchError((error) {});
  }
}
