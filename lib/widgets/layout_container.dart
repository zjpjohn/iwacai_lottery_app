import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/widgets/nav_app_bar.dart';

class LayoutContainer extends StatelessWidget {
  ///
  ///
  final String title;

  ///
  /// appbar是否显示底部border
  final bool border;

  ///
  /// header部分组件
  final Widget? header;

  ///
  /// 右侧组件
  final Widget? right;

  ///
  final Widget content;

  final bool left;

  LayoutContainer({
    Key? key,
    required this.content,
    this.border = true,
    this.title = '',
    this.header,
    this.right,
    this.left = true,
  })  : assert((title.isNotEmpty && header == null) ||
            (title.isEmpty && header != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              NavAppBar(
                border: border,
                center: title.isEmpty
                    ? header!
                    : Text(
                        title,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18.sp,
                        ),
                      ),
                left: left
                    ? Container(
                        width: 32.w,
                        height: 32.w,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          const IconData(0xe669, fontFamily: 'iconfont'),
                          size: 18.w,
                          color: Colors.black87,
                        ),
                      )
                    : Container(),
                right: right,
              ),
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}
