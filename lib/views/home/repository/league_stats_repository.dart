import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/feature_league.dart';
import 'package:iwacai_lottery_app/views/base/model/league_stats.dart';

class LeagueStatsRepository {
  ///
  ///联赛大小球统计
  ///
  static Future<List<StatsInfo<BigSmallStats>>> bigSmallStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/bigAndSmall',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => BigSmallStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 常见比分统计
  ///
  static Future<List<StatsInfo<CommonGoalStats>>> commonGoalStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/commonGoal',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => CommonGoalStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 半场全场统计
  ///
  static Future<List<StatsInfo<HalfAllStats>>> halfAllStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/halfAll',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => HalfAllStats.fromJson(s)))
          .toList();
    });
  }

  ///
  ///半场比分统计
  ///
  static Future<List<StatsInfo<HalfGoalStats>>> halfGoalStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/halfGoal',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => HalfGoalStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 奇偶比分统计
  ///
  static Future<List<StatsInfo<OddEvenStats>>> oddsEvenStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/oddsAndEven',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => OddEvenStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 进球统计
  ///
  static Future<List<StatsInfo<PointGoalStats>>> pointGoalStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/pointGoal',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => PointGoalStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 盘路统计
  ///
  static Future<List<StatsInfo<TeamTapeStats>>> teamTapeStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/teamTape',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => TeamTapeStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 胜负统计
  ///
  static Future<List<StatsInfo<WinLossStats>>> winLossStats(
      {required int seasonId, required int type}) {
    return HttpRequest().get('/ssport/share/stats/winLoss',
        params: {'seasonId': seasonId, 'type': type}).then((value) {
      List list = value.data;
      return list
          .map((e) => StatsInfo.fromJson(e, (s) => WinLossStats.fromJson(s)))
          .toList();
    });
  }

  ///
  /// 联赛胜平负特征
  ///
  static Future<FeatureWinLose> featureWinLose(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/league/feature/winLose/$seasonId')
        .then((value) => FeatureWinLose.fromJson(value.data ?? {}));
  }

  ///
  /// 联赛进球特征
  ///
  static Future<FeatureBigSmall> featureBigSmall(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/league/feature/bigSmall/$seasonId')
        .then((value) => FeatureBigSmall.fromJson(value.data ?? {}));
  }

  ///
  /// 联赛让球特征
  ///
  static Future<FeatureUpDown> featureUpDown(int seasonId) {
    return HttpRequest()
        .get('/ssport/share/league/feature/upDown/$seasonId')
        .then((value) => FeatureUpDown.fromJson(value.data ?? {}));
  }
}
