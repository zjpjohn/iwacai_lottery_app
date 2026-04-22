import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/stats/controller/stats_big_small_controller.dart';
import 'package:iwacai_lottery_app/views/stats/controller/stats_half_all_controller.dart';
import 'package:iwacai_lottery_app/views/stats/controller/stats_odds_even_controller.dart';
import 'package:iwacai_lottery_app/views/stats/controller/stats_point_goal_controller.dart';
import 'package:iwacai_lottery_app/views/stats/controller/stats_win_loss_controller.dart';

class StatBigSmallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsBigSmallController());
  }
}

class StatHalfAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsHalfAllController());
  }
}

class StatOddsEvenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsOddsEvenController());
  }
}

class StatPointGoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsPointGoalController());
  }
}

class StatWinLossBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsWinLossController());
  }
}
