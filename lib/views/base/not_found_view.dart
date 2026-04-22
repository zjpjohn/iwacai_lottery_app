import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';
import 'package:iwacai_lottery_app/widgets/not_found_widget.dart';

class RouteUnknownView extends StatelessWidget {
  ///
  ///
  const RouteUnknownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      border: false,
      header: const SizedBox.shrink(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NotFoundView(size: 168.w),
        ],
      ),
    );
  }
}
