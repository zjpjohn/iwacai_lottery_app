import 'dart:async';

import 'package:iwacai_lottery_app/env/env_profile.dart';
import 'package:iwacai_lottery_app/store/config.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/help/model/app_assistant.dart';
import 'package:iwacai_lottery_app/views/help/repository/assistant_repository.dart';

class AppAssistantController extends BaseRequestController {
  ///
  List<AppAssistant> assistants = [];

  @override
  Future<void> request() async {
    showLoading();
    AssistantRepository.appAssistants(
      appNo: Profile.props.appNo,
      version: ConfigStore().version,
    ).then((value) {
      assistants
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(assistants);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
