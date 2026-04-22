import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_topic_controller.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_billboard_controller.dart';

class NewsBillboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsBillboardController());
  }
}

class NewsTopicBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsTopicController());
  }
}
