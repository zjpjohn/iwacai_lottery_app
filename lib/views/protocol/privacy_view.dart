import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyProtocolView extends StatelessWidget {
  const PrivacyProtocolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '隐私政策',
      content: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(
            Uri.parse('https://cdn.icaiwa.com/protocols/privacy.html'),
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                EasyLoading.show();
              },
              onPageFinished: (url) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  EasyLoading.dismiss();
                });
              },
            ),
          ),
      ),
    );
  }
}
