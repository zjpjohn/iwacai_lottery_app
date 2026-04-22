import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme_detail.dart';

class ExpertSchemeRepository {
  ///
  /// 分页查询推荐方案
  ///
  static Future<PageResult<ExpertScheme>> getExpSchemeList(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/scheme/list', params: params)
        .then((value) {
      return PageResult.fromJson(
        json: value.data,
        handle: (data) => ExpertScheme.fromJson(data),
      );
    });
  }

  ///
  /// 查询专家历史分析
  ///
  static Future<PageResult<ExpertScheme>> getHistorySchemes(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ssport/scheme/histories', params: params)
        .then((value) {
      return PageResult.fromJson(
        json: value.data,
        handle: (data) => ExpertScheme.fromJson(data),
      );
    });
  }

  ///
  /// 查询推荐方案详情
  ///
  static Future<ExpSchemeDetail> getSchemeDetail(String seqNo) {
    return HttpRequest()
        .get('/ssport/scheme/detail/$seqNo')
        .then((value) => ExpSchemeDetail.fromJson(value.data));
  }

  ///
  /// 点赞推荐方案
  ///
  static Future<void> praiseScheme(String seqNo) {
    return HttpRequest()
        .put('/ssport/scheme/praise/$seqNo')
        .then((value) => null);
  }

  ///
  /// 订阅推荐方案专家
  ///
  static Future<void> subscribeExpert(String expNo) {
    return HttpRequest()
        .post('/ssport/scheme/expert/$expNo')
        .then((value) => null);
  }

  ///
  /// 取消推荐专家订阅
  ///
  static Future<void> cancelSubscribe(String expNo) {
    return HttpRequest()
        .delete('/ssport/scheme/expert/$expNo')
        .then((value) => null);
  }
}
