import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/consume_record_controller.dart';
import 'package:iwacai_lottery_app/views/user/controller/exchange_record_controller.dart';
import 'package:iwacai_lottery_app/views/user/controller/withdraw_record_controller.dart';

class ConsumeRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsumerRecordController());
  }
}

class ExchangeRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExchangeRecordController());
  }
}

class WithdrawLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WithdrawRecordController());
  }
}
