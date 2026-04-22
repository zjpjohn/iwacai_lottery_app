import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/controller/browse_record_controller.dart';

class BrowseRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BrowseRecordController());
  }
}
