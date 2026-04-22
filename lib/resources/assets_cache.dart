import 'package:flutter/material.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

///
///
class AssetsCache {
  ///
  /// 图片资源预缓存
  ///
  static void preCacheImages(BuildContext context) {
    precacheImage(const AssetImage(R.homeHeader1), context);
    precacheImage(const AssetImage(R.homeHeader2), context);
    precacheImage(const AssetImage(R.homeHeader3), context);
    precacheImage(const AssetImage(R.homeHeader4), context);
    precacheImage(const AssetImage(R.homeHeader5), context);
    precacheImage(const AssetImage(R.scheduleBackground), context);

    precacheImage(const AssetImage(R.home), context);
    precacheImage(const AssetImage(R.homeOn), context);
    precacheImage(const AssetImage(R.news), context);
    precacheImage(const AssetImage(R.newsOn), context);
    precacheImage(const AssetImage(R.bifen), context);
    precacheImage(const AssetImage(R.bifenOn), context);
    precacheImage(const AssetImage(R.mine), context);
    precacheImage(const AssetImage(R.mineOn), context);

    precacheImage(const AssetImage(R.avatar), context);
    precacheImage(const AssetImage(R.unLogin), context);

    precacheImage(const AssetImage(R.error), context);
    precacheImage(const AssetImage(R.empty), context);
    precacheImage(const AssetImage(R.defaultNews), context);

    precacheImage(const AssetImage(R.sportMatchBg), context);
    precacheImage(const AssetImage(R.sportMatchBg1), context);
    precacheImage(const AssetImage(R.sportMatchBg2), context);
    precacheImage(const AssetImage(R.football), context);
    precacheImage(const AssetImage(R.teamHeaderBg), context);
    precacheImage(const AssetImage(R.splash), context);
    precacheImage(const AssetImage(R.football1), context);
    precacheImage(const AssetImage(R.leagueSchedule), context);
    precacheImage(const AssetImage(R.standPoint), context);
    precacheImage(const AssetImage(R.accountBg), context);
    precacheImage(const AssetImage(R.rightSign), context);
    precacheImage(const AssetImage(R.voucherIcon), context);
  }
}
