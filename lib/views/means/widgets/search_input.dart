import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

typedef OnSubmitted = void Function(String value);
typedef OnValueChanged = void Function(String value);

class SearchInput extends StatefulWidget {
  ///
  ///
  const SearchInput({
    Key? key,
    this.searchHeight = 48,
    this.hintText,
    this.value = '',
    this.vertical = 8,
    this.onSubmitted,
    this.onValueChanged,
  }) : super(key: key);

  final double searchHeight;
  final String? hintText;
  final String value;
  final double vertical;
  final OnSubmitted? onSubmitted;
  final OnValueChanged? onValueChanged;

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  ///
  final TextEditingController _controller = TextEditingController();

  ///
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.searchHeight,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color(0xFFF3F3F3), width: 0.3.w),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 12.w),
              child: Icon(
                const IconData(0xe669, fontFamily: 'iconfont'),
                size: 20.w,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24.w),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: widget.vertical),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      border: Border.all(
                        width: 0.1.w,
                        color: const Color(0xFFF6F6F6),
                      ),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1.w, left: 10.w),
                        child: Icon(
                          const IconData(0xe62f, fontFamily: 'iconfont'),
                          size: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          height: widget.searchHeight,
                          child: TextField(
                            maxLines: 1,
                            textInputAction: TextInputAction.search,
                            controller: _controller,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                              decoration: TextDecoration.none,
                            ),
                            decoration: InputDecoration(
                              hintText: widget.hintText ?? '',
                              border: InputBorder.none,
                            ),
                            onSubmitted: (text) {
                              widget.onSubmitted!(text);
                            },
                            onChanged: (text) {
                              widget.onValueChanged!(text);
                            },
                          ),
                        ),
                      ),
                      if (_text.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(right: 16.w),
                          child: GestureDetector(
                            onTap: () {
                              _controller.text = '';
                              widget.onValueChanged!('');
                            },
                            child: Image.asset(
                              R.close,
                              width: 18.w,
                              height: 18.w,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          widget.onSubmitted!(_controller.text);
                        },
                        child: Container(
                          height: 28.w,
                          margin: EdgeInsets.only(right: 2.w),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2866D5).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '搜索',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFF2866D5),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _text = _controller.text;
        });
      }
    });
  }
}
