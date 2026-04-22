import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme_detail.dart';
import 'package:iwacai_lottery_app/views/scheme/repository/expert_scheme_repository.dart';

class SchemeDetailController extends BaseRequestController {
  ///
  /// 方案详情
  late ExpSchemeDetail scheme;

  ///
  /// 方案标识
  late String seqNo;

  ///
  ///点赞方案
  ///
  void praiseScheme() {
    if (scheme.hasPraised == 1) {
      return;
    }
    EasyLoading.show(status: '操作中');
    ExpertSchemeRepository.praiseScheme(seqNo).then((_) {
      scheme.praise++;
      scheme.hasPraised = 1;
      update();
    }).whenComplete(() {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => EasyLoading.dismiss(),
      );
    });
  }

  void subscribeAction() {
    if (scheme.hasSubscribed == 0) {
      EasyLoading.show(status: '正在关注');
      ExpertSchemeRepository.subscribeExpert(scheme.expertNo).then((_) {
        scheme.hasSubscribed = 1;
        scheme.subscribes = scheme.subscribes + 1;
        update();
      }).whenComplete(() {
        Future.delayed(
          const Duration(milliseconds: 200),
          () => EasyLoading.dismiss(),
        );
      });
      return;
    }
    EasyLoading.show(status: '正在取消');
    ExpertSchemeRepository.subscribeExpert(scheme.expertNo).then((_) {
      scheme.hasSubscribed = 0;
      scheme.subscribes = scheme.subscribes - 1;
      update();
    }).whenComplete(() {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => EasyLoading.dismiss(),
      );
    });
  }

  ///
  /// 订阅专家
  ///
  void subscribeExpert() {
    if (scheme.hasSubscribed == 1) {
      return;
    }
    EasyLoading.show(status: '操作中');
    ExpertSchemeRepository.subscribeExpert(scheme.expertNo).then((_) {
      scheme.hasSubscribed = 1;
      update();
    }).whenComplete(() {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => EasyLoading.dismiss(),
      );
    });
  }

  @override
  Future<void> request() async {
    seqNo = Get.parameters['seqNo']!;
    ExpertSchemeRepository.getSchemeDetail(seqNo).then((value) {
      scheme = value;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(value);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
