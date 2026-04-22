import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UsageProtocolView extends StatelessWidget {
  const UsageProtocolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '使用协议',
      content: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(
            Uri.parse('https://cdn.icaiwa.com/protocols/usage.html'),
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
