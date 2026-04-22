import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/widgets/path_clippers.dart';

class LoginBackground extends StatelessWidget {
  final String title;

  const LoginBackground({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: deviceSize.height * 0.45,
          child: Stack(
            children: <Widget>[
              Stack(
                children: [
                  ClipPath(
                    clipper: LoginBackClipper(left: false, delta: 96.w),
                    child: Container(
                      color: const Color(0xFFF6DBC8),
                    ),
                  ),
                  ClipPath(
                    clipper: LoginBackClipper(delta: 96.w),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE6D1C0),
                            Color(0xFFD8B28E),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: statusBarHeight),
                height: 44 + statusBarHeight,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 32.w,
                          width: 32.w,
                          padding: EdgeInsets.only(left: 12.w),
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.keyboard_arrow_left,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      flex: 2,
                    ),
                    const Expanded(
                      child: Text(''),
                      flex: 1,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
