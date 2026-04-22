import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';

class KefuContactController extends BaseRequestController {
  ///
  ///
  final FocusNode focusNode = FocusNode();

  ///
  ///图片选择器
  final ImagePicker picker = ImagePicker();

  ///
  ///
  final TextEditingController textController = TextEditingController();

  ///
  /// 显示上传组件
  bool _showUpload = false;

  ///
  /// 输入消息内容
  String _content = '';

  ///
  /// 消息内容集合
  List<KefuMessage> messages = [];

  set showUpload(bool value) {
    if (value) {
      focusNode.unfocus();
      textController.clear();
      Future.delayed(const Duration(milliseconds: 80), () {
        _showUpload = value;
        update();
      });
      return;
    }
    _showUpload = value;
    update();
  }

  bool get showUpload => _showUpload;

  set content(String value) {
    _content = value;
    update();
  }

  String get content => _content;

  ///
  /// 发送图片
  void sendImage(ImageSource source) {
    picker.pickImage(imageQuality: 25, source: source).then((file) {
      if (file == null) {
        return;
      }
      messages.add(KefuMessage(
        type: 'user',
        time: DateTime.now(),
        message: file.path,
        messageType: MessageType.image,
      ));
      update();
    });
  }

  ///
  /// 发送客服消息
  void send() {
    messages.add(KefuMessage(
      type: 'user',
      time: DateTime.now(),
      message: content,
      messageType: MessageType.text,
    ));
    _content = '';
    textController.clear();
    focusNode.unfocus();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showUpload = false;
      }
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

enum MessageType { text, image }

class KefuMessage {
  late String type;
  late DateTime time;
  late String message;
  late String sessionId;
  late String userId;
  late MessageType messageType;
  late MessageTime messageTime;

  KefuMessage({
    required this.type,
    required this.time,
    required this.message,
    required this.messageType,
    this.sessionId = '',
    this.userId = '',
  }) {
    messageTime = MessageTime(timestamp: time);
  }

  KefuMessage.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    time = DateUtil.parse(json['time'], pattern: "yyyy/MM/dd HH:mm:ss");
    message = json['message'];
    sessionId = json['sessionId'];
    userId = json['userId'];
    messageTime = MessageTime(timestamp: time);
    messageType =
        json['messageType'] == 'text' ? MessageType.text : MessageType.image;
  }
}

class MessageTime {
  ///
  /// 消息时间
  late DateTime timestamp;

  //消息日期
  late String date;

  //消息时间
  late String time;

  MessageTime({required this.timestamp}) {
    String minute = '${timestamp.minute}'.padLeft(2, '0');
    String hour = '${timestamp.hour}'.padLeft(2, '0');
    time = '$hour:$minute';
    date = getDate();
  }

  String getDate() {
    int delta = DateTime.now().day - timestamp.day;
    if (delta == 0) {
      return '今天';
    }
    if (delta == 1) {
      return '昨天';
    }
    if (delta == 2) {
      return '前天';
    }
    return DateUtil.formatDate(timestamp, format: 'yyyy.MM.dd');
  }
}
