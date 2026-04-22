import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/feedback/repository/feedback_repository.dart';
import 'package:iwacai_lottery_app/views/upload/upload_image_widget.dart';

class AppFeedbackController extends BaseRequestController {
  ///
  ///文本控制数据
  final TextEditingController controller = TextEditingController();

  ///
  /// 上传组件唯一标识
  final GlobalKey<UploadImageState> uploadKey = GlobalKey<UploadImageState>();

  ///
  /// 反馈类型
  int? _type;

  ///
  /// 反馈内容
  String? _content;

  ///
  /// 反馈图片集合
  List<String> images = [];

  ///
  /// 提交状态
  bool submit = false;

  set type(int? type) {
    _type = type;
    update();
  }

  int? get type => _type;

  set content(String? content) {
    _content = content;
    update();
  }

  String? get content => _content;

  Future<void> submitFeedback() async {
    if (type == null) {
      EasyLoading.showToast('请选择反馈分类');
      return;
    }
    if (content == null || content!.isEmpty) {
      EasyLoading.showToast('请输入反馈内容');
      return;
    }
    return FeedbackRepository.submitFeedback(FeedbackInfo(
      type: type!,
      content: content!,
      images: images,
    )).then((value) {
      type = null;
      content = null;
      images.clear();
      controller.clear();
      update();
      uploadKey.currentState?.clearAll();
      EasyLoading.showToast('提交成功');
    }).catchError((error) {
      EasyLoading.showToast('提交失败');
    });
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 250), () {
      showSuccess(true);
    });
  }
}

class FeedbackInfo {
  ///
  /// 反馈类型
  late int type;

  ///
  /// 反馈内容
  late String content;

  ///
  /// 反馈图片集合
  List<String>? images;

  FeedbackInfo({
    required this.type,
    required this.content,
    this.images,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['type'] = type;
    json['content'] = content;
    json['images'] = images!;
    return json;
  }
}
