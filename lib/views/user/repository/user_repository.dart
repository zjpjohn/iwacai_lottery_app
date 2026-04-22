import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/user/model/auth_mobile.dart';
import 'package:iwacai_lottery_app/views/user/model/balance_log.dart';
import 'package:iwacai_lottery_app/views/user/model/user_agent_rule.dart';
import 'package:iwacai_lottery_app/views/user/model/user_assistant.dart';
import 'package:iwacai_lottery_app/views/user/model/user_auth.dart';
import 'package:iwacai_lottery_app/views/user/model/user_balance.dart';
import 'package:iwacai_lottery_app/views/user/model/user_info.dart';
import 'package:iwacai_lottery_app/views/user/model/user_invite.dart';
import 'package:iwacai_lottery_app/views/user/model/user_sign.dart';
import 'package:iwacai_lottery_app/views/user/model/user_withdraw.dart';

class UserInfoRepository {
  ///
  /// 发送短信验证码
  static Future<void> sendSms(
      {required String phone, required String channel}) {
    return HttpRequest().post(
      '/dysms/sms',
      params: {'phone': phone, 'channel': channel},
    ).then((value) => null);
  }

  ///
  /// 短信验证码授权登录
  static Future<AuthInfo> authLogin({
    required String phone,
    required String code,
    int? channel,
    String? invCode,
  }) {
    return HttpRequest().post(
      '/ucenter/app/user/auth',
      params: {'type': 1},
      data: {
        'phone': phone,
        'code': code,
        'channel': channel ?? 3,
        'invite': invCode,
      },
    ).then((value) => AuthInfo.fromJson(value.data));
  }

  ///
  /// 重置登录密码
  static Future<void> resetPassword(
      {required String code,
      required String password,
      required String confirm}) {
    return HttpRequest().put(
      '/ucenter/app/user/reset',
      data: {
        'code': code,
        'password': password,
        'confirm': confirm,
      },
    ).then((_) => null);
  }

  ///
  /// 密码授权登录
  static Future<AuthInfo> pwdAuth({
    required String phone,
    required String password,
    int? channel,
  }) {
    return HttpRequest().post(
      '/ucenter/app/user/auth',
      params: {'type': 3},
      data: {
        'phone': phone,
        'password': password,
        'channel': channel ?? 3,
      },
    ).then((value) => AuthInfo.fromJson(value.data));
  }

  ///
  /// 一键登录换取手机号
  static Future<AuthMobile> authMobile(String token) {
    return HttpRequest().get(
      '/dysms/mobile/',
      params: {'token': token},
    ).then((value) => AuthMobile.fromJson(value.data));
  }

  ///
  /// 一键快速登录
  ///
  static Future<AuthInfo> quickAuth({
    required String phone,
    required String nonceStr,
    required String signature,
    int? channel,
    String? invCode,
  }) {
    return HttpRequest().post(
      '/ucenter/app/user/auth',
      params: {'type': 2},
      data: {
        'phone': phone,
        'nonceStr': nonceStr,
        'signature': signature,
        'channel': channel,
        'invite': invCode,
      },
    ).then((value) => AuthInfo.fromJson(value.data));
  }

  ///
  /// 用户退出登录
  ///
  static Future<void> loginOut() {
    return HttpRequest()
        .post('/ucenter/app/user/loginOut')
        .then((value) => null)
        .catchError((error) => null);
  }

  ///
  /// 查询账户余额详情
  ///
  static Future<UserBalance> userBalance() {
    return HttpRequest()
        .get('/ucenter/app/user/balance')
        .then((value) => UserBalance.fromJson(value.data))
        .catchError((error) => Future.value(UserBalance.fromJson({})));
  }

  ///
  /// 查询用户信息
  static Future<UserInfo> userInfo() {
    return HttpRequest()
        .get('/ucenter/app/user/')
        .then((value) => UserInfo.fromJson(value.data));
  }

  ///
  /// 用户邀请信息
  ///
  static Future<UserInvite> userInvite() {
    return HttpRequest()
        .get('/ucenter/app/invite/')
        .then((value) => UserInvite.fromJson(value.data));
  }

  ///
  /// 用户流量主规则
  ///
  static Future<UserAgentRule> agentRule() {
    return HttpRequest()
        .get('/ucenter/app/invite/rule')
        .then((value) => UserAgentRule.fromJson(value.data));
  }

  ///
  /// 查询邀请用户集合
  ///
  static Future<PageResult<UserInfo>> inviteUsers(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ucenter/app/invite/users',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => UserInfo.fromJson(e),
      ),
    );
  }

  ///
  /// 分页查询余额账户日志
  ///
  static Future<PageResult<BalanceLog>> balanceLogs({
    required int direct,
    required int type,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get(
      '/ucenter/app/user/balance/logs',
      params: {
        'direct': direct,
        'type': type,
        'page': page,
        'limit': limit,
      },
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BalanceLog.fromJson(e),
      ),
    );
  }

  ///
  /// 积分兑换记录
  ///
  static Future<PageResult<BalanceLog>> couponLogs(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ucenter/app/user/coupon/exchange/logs',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BalanceLog.fromJson(e),
      ),
    );
  }

  ///
  /// 用户消费金币记录
  ///
  static Future<PageResult<BalanceLog>> consumeRecords(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ucenter/app/user/consume/logs',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => BalanceLog.fromJson(e),
      ),
    );
  }

  ///
  /// 提现记录查询
  ///
  static Future<PageResult<WithdrawRecord>> withdrawRecords({
    required String scene,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().get('/ucenter/app/withdraw/list', params: {
      'scene': scene,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => WithdrawRecord.fromJson(e),
      ),
    );
  }

  ///
  /// 用户签到
  static Future<SignResult> userSign() {
    return HttpRequest()
        .post('/ucenter/app/sign/')
        .then((value) => SignResult.fromJson(value.data));
  }

  ///
  /// 查询签到信息
  static Future<SignInfo> querySignInfo() {
    return HttpRequest()
        .get('/ucenter/app/sign/')
        .then((value) => SignInfo.fromJson(value.data));
  }

  ///
  /// 查询签到日志
  static Future<PageResult<SignLog>> querySignLogs(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ucenter/app/sign/logs', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (value) => SignLog.fromJson(value),
            ));
  }

  ///
  /// 积分兑换
  ///
  static Future<ExchangeResult> couponExchange() {
    return HttpRequest()
        .post('/ucenter/app/user/coupon')
        .then((value) => ExchangeResult.fromJson(value.data));
  }

  ///
  /// 查询应用助手信息
  static Future<List<UserAssistant>> appAssistants({
    required String appNo,
    required String version,
    String? type,
    bool detail = false,
  }) {
    return HttpRequest().get('/lope/app/assistant/list', params: {
      'appNo': appNo,
      'version': version,
      'type': type,
      'detail': detail,
    }).then((value) {
      List result = value.data;
      return result.map((e) => UserAssistant.fromJson(e)).toList();
    });
  }
}
