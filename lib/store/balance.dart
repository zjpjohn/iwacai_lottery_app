import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/model/user_balance.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';

class BalanceInstance extends GetxController {
  ///
  ///
  static BalanceInstance? _instance;

  factory BalanceInstance() {
    BalanceInstance._instance ??=
        Get.put<BalanceInstance>(BalanceInstance._initialize());
    return BalanceInstance._instance!;
  }

  BalanceInstance._initialize();

  ///
  /// 余额账户
  UserBalance? _balance;

  ///
  /// 获取余额账户
  UserBalance? get balance => _balance;

  set incrCoupon(int coupon) {
    if (_balance != null) {
      _balance!.coupon = _balance!.coupon + coupon;
      update();
    }
  }

  set balance(UserBalance? balance) {
    _balance = balance;
    update();
  }

  ///
  /// 刷新余额账户
  Future<void> refreshBalance() async {
    try {
      balance = await UserInfoRepository.userBalance();
      update();
    } catch (_) {}
  }

  Future<void> refreshIfNull() async {
    if (balance == null) {
      refreshBalance();
    }
  }

  ///
  /// 兑换积分
  void exchangeCoupon() {}

  ///
  /// 提现
  void withdrawRmb() {}
}
