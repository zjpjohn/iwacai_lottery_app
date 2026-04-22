import 'package:iwacai_lottery_app/env/env_profile.dart';
import 'package:iwacai_lottery_app/store/config.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/user/model/user_assistant.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';

class AboutAccountController extends BaseRequestController {
  ///
  List<UserAssistant> assistants = [];

  @override
  Future<void> request() async {
    showLoading();
    UserInfoRepository.appAssistants(
      appNo: Profile.props.appNo,
      version: ConfigStore().version,
      type: 'acct',
      detail: true,
    ).then((value) {
      assistants
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(assistants);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
