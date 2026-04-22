import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/odds_info.dart';
import 'package:iwacai_lottery_app/views/base/model/odds_provider.dart';

///
///
class OddsInfoRepository {
  ///
  /// 赔率公司列表
  ///
  static Future<List<OddsProvider>> providerList() {
    return HttpRequest().get('/ssport/share/bwin/providers').then((value) {
      List list = value.data;
      return list.map((e) => OddsProvider.fromJson(e)).toList();
    });
  }

  ///
  /// 比赛亚盘赔率
  ///
  static Future<List<AsianOdds>> matchAsianOdds(int matchId) {
    return HttpRequest().get('/ssport/app/odds/asian/$matchId').then((value) {
      List list = value.data;
      return list.map((e) => AsianOdds.fromJson(e)).toList();
    });
  }

  ///
  /// 查询比赛亚盘历史赔率
  ///
  static Future<List<AsianOddsHistory>> matchAsianHistories(
      {required int matchId, required int providerId, required int oddsId}) {
    return HttpRequest().get(
        '/ssport/app/odds/asian/history/$matchId/$providerId',
        params: {'odds': oddsId}).then((value) {
      List list = value.data;
      return list.map((e) => AsianOddsHistory.fromJson(e)).toList();
    });
  }

  ///
  /// 比赛让球赔率
  ///
  static Future<List<BosOdds>> matchBosOdds(int matchId) {
    return HttpRequest().get('/ssport/app/odds/bos/$matchId').then((value) {
      List list = value.data;
      return list.map((e) => BosOdds.fromJson(e)).toList();
    });
  }

  ///
  /// 查询比赛让球历史赔率
  ///
  static Future<List<BosOddsHistory>> matchBosHistories(
      {required int matchId, required int providerId, required int oddsId}) {
    return HttpRequest().get(
        '/ssport/app/odds/bos/history/$matchId/$providerId',
        params: {'odds': oddsId}).then((value) {
      List list = value.data;
      return list.map((e) => BosOddsHistory.fromJson(e)).toList();
    });
  }

  ///
  /// 比赛欧赔赔率
  ///
  static Future<List<EuroOdds>> matchEuroOdds(int matchId) {
    return HttpRequest().get('/ssport/app/odds/euro/$matchId').then((value) {
      List list = value.data;
      return list.map((e) => EuroOdds.fromJson(e)).toList();
    });
  }

  ///
  /// 查询比赛欧赔历史赔率
  ///
  static Future<List<EuroOddsHistory>> matchEuroHistories({
    required int matchId,
    required int providerId,
    required int oddsId,
  }) {
    return HttpRequest().get(
        '/ssport/app/odds/euro/history/$matchId/$providerId',
        params: {'odds': oddsId}).then((value) {
      List list = value.data;
      return list.map((e) => EuroOddsHistory.fromJson(e)).toList();
    });
  }
}
