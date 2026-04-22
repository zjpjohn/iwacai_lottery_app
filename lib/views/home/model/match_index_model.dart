import 'package:iwacai_lottery_app/views/base/model/league_stats.dart';

class BigSmallIndex {
  ///主队大小球统计数据
  StatsInfo<BigSmallStats>? home;

  ///客队大小球统计数据
  StatsInfo<BigSmallStats>? away;

  BigSmallIndex.fromJson(Map<String, dynamic> json) {
    if (json['home'] != null) {
      home = StatsInfo<BigSmallStats>.fromJson(
        json['home'],
        (json) => BigSmallStats.fromJson(json),
      );
    }
    if (json['away'] != null) {
      away = StatsInfo<BigSmallStats>.fromJson(
        json['away'],
        (json) => BigSmallStats.fromJson(json),
      );
    }
  }
}

class WinLossIndex {
  StatsInfo<WinLossStats>? home;
  StatsInfo<WinLossStats>? away;

  WinLossIndex.fromJson(Map<String, dynamic> json) {
    if (json['home'] != null) {
      home = StatsInfo<WinLossStats>.fromJson(
          json['home'], (json) => WinLossStats.fromJson(json));
    }
    if (json['away'] != null) {
      away = StatsInfo<WinLossStats>.fromJson(
          json['away'], (json) => WinLossStats.fromJson(json));
    }
  }
}

class PointGoalIndex {
  ///主队进球统计数据
  StatsInfo<PointGoalStats>? home;

  ///客队进球统计数据
  StatsInfo<PointGoalStats>? away;

  PointGoalIndex.fromJson(Map<String, dynamic> json) {
    if (json['home'] != null) {
      home = StatsInfo<PointGoalStats>.fromJson(
          json['home'], (json) => PointGoalStats.fromJson(json));
    }
    if (json['away'] != null) {
      away = StatsInfo<PointGoalStats>.fromJson(
          json['away'], (json) => PointGoalStats.fromJson(json));
    }
  }
}
