import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/news/model/billboard_news.dart';
import 'package:iwacai_lottery_app/views/news/model/channel_news.dart';
import 'package:iwacai_lottery_app/views/news/model/news_topic.dart';
import 'package:iwacai_lottery_app/views/news/model/sport_news.dart';

class SportNewsRepository {
  ///
  /// 分页查询新闻资讯
  ///
  static Future<PageResult<SportNews>> getNewsList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/app/news/list', params: params)
        .then((value) {
      return PageResult.fromJson(
        json: value.data,
        handle: (data) => SportNews.fromJson(data),
      );
    });
  }

  ///
  /// 查询新闻资讯详情
  ///
  static Future<SportNews> sportNews(int newsId) {
    return HttpRequest()
        .get('/ssport/app/news/detail/$newsId')
        .then((value) => SportNews.fromJson(value.data));
  }

  ///
  /// 新闻点赞
  ///
  static Future<void> praiseNews(int newsId) {
    return HttpRequest()
        .put('/ssport/app/news/praise/$newsId')
        .then((value) => null);
  }

  ///
  /// 查询置顶资讯
  ///
  static Future<ChannelNews> channelTop() {
    return HttpRequest()
        .get('/ssport/app/news/channel/top')
        .then((value) => ChannelNews.fromJson(value.data));
  }

  ///
  /// 查询热点资讯榜单
  ///
  static Future<List<BillboardNews>> billboardNewsList() {
    return HttpRequest().get('/ssport/app/news/billboard').then(
          (value) => (value.data as List)
              .map((e) => BillboardNews.fromJson(e))
              .toList(),
        );
  }

  ///
  /// 查询热门资讯话题
  ///
  static Future<List<SportNewsTopic>> hotTopicList() {
    return HttpRequest().get('/ssport/app/topic/list').then(
          (value) => (value.data as List)
              .map((e) => SportNewsTopic.fromJson(e))
              .toList(),
        );
  }

  ///
  /// 查询咨询话题详情
  ///
  static Future<SportNewsTopic> newsTopic(int topicId) {
    return HttpRequest()
        .get('/ssport/share/topic/$topicId')
        .then((value) => SportNewsTopic.fromJson(value.data));
  }

  ///
  /// 分页查询话题咨询列表
  ///
  static Future<PageResult<TopicNewsItem>> topicNewsList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/share/topic/news', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (data) => TopicNewsItem.fromJson(data),
            ));
  }
}
