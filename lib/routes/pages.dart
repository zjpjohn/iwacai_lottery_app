import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/routes/intercepts/route_auth.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/views/about/view.dart';
import 'package:iwacai_lottery_app/views/feedback/index.dart';
import 'package:iwacai_lottery_app/views/help/index.dart';
import 'package:iwacai_lottery_app/views/home/pages/home_focus_view.dart';
import 'package:iwacai_lottery_app/views/home/pages/league_schedule_view.dart';
import 'package:iwacai_lottery_app/views/home/pages/match_detail_view.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/match_filter_view.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/match_setting_view.dart';
import 'package:iwacai_lottery_app/views/main/index.dart';
import 'package:iwacai_lottery_app/views/means/bindings/country_league_bindings.dart';
import 'package:iwacai_lottery_app/views/means/bindings/league_detail_bindings.dart';
import 'package:iwacai_lottery_app/views/means/bindings/league_search_bindings.dart';
import 'package:iwacai_lottery_app/views/means/pages/area_country_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/country_league_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/league_detail_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/league_search_view.dart';
import 'package:iwacai_lottery_app/views/news/bindings/sport_news_bindings.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_billboard_view.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_detail_view.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_topic_view.dart';
import 'package:iwacai_lottery_app/views/protocol/beian_miit_view.dart';
import 'package:iwacai_lottery_app/views/protocol/credential_view.dart';
import 'package:iwacai_lottery_app/views/protocol/permission_view.dart';
import 'package:iwacai_lottery_app/views/protocol/privacy_view.dart';
import 'package:iwacai_lottery_app/views/protocol/usage_view.dart';
import 'package:iwacai_lottery_app/views/scheme/pages/scheme_detail_view.dart';
import 'package:iwacai_lottery_app/views/scheme/pages/scheme_history_view.dart';
import 'package:iwacai_lottery_app/views/scheme/pages/scheme_list_view.dart';
import 'package:iwacai_lottery_app/views/splash/splash_view.dart';
import 'package:iwacai_lottery_app/views/stats/bindings/stats_bindings.dart';
import 'package:iwacai_lottery_app/views/stats/pages/stats_big_small_view.dart';
import 'package:iwacai_lottery_app/views/stats/pages/stats_half_all_view.dart';
import 'package:iwacai_lottery_app/views/stats/pages/stats_odds_even_view.dart';
import 'package:iwacai_lottery_app/views/stats/pages/stats_point_goal_view.dart';
import 'package:iwacai_lottery_app/views/stats/pages/stats_win_loss_view.dart';
import 'package:iwacai_lottery_app/views/subscribe/views/focus_center_view.dart';
import 'package:iwacai_lottery_app/views/team/bindings/team_center_bindings.dart';
import 'package:iwacai_lottery_app/views/team/pages/team_center_view.dart';
import 'package:iwacai_lottery_app/views/user/bindings/about_account_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/browse_record_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/kefu_contact_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/message_center_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/reset_password_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/user_balance_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/user_invite_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/user_rights_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/user_sign_bindings.dart';
import 'package:iwacai_lottery_app/views/user/bindings/user_voucher_bindings.dart';
import 'package:iwacai_lottery_app/views/user/index.dart';
import 'package:iwacai_lottery_app/views/user/pages/about_account_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/browse_record_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/invite_history_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/kefu_contact_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/message/channel_message_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/message/channel_setting_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/message/message_center_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/records/consume_record_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/records/exchange_record_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/records/withdraw_record_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/reset_password_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/user_account_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/user_balance_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/user_invite_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/user_rights_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/user_setting_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/user_sign_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/voucher/draw_voucher_view.dart';
import 'package:iwacai_lottery_app/views/user/pages/voucher/user_voucher_view.dart';

import '../views/home/pages/home_result_view.dart';

class AppPages {
  ///
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  ///
  /// 路由集合
  ///
  static final routes = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      transition: Transition.noTransition,
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      transition: Transition.noTransition,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const UserLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.balance,
      page: () => const UserBalanceView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const UserAccountView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.accountAbout,
      page: () => const AboutAccountView(),
      binding: AboutAccountBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.reset,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.voucher,
      page: () => const UserVoucherView(),
      binding: UserVoucherBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.voucherDraw,
      page: () => const DrawVoucherView(),
      binding: DrawVoucherBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.consume,
      page: () => const ConsumeRecordView(),
      binding: ConsumeRecordBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.exchange,
      page: () => const ExchangeRecordView(),
      binding: ExchangeRecordBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.withdraw,
      page: () => const WithdrawRecordView(),
      transition: Transition.rightToLeft,
      binding: WithdrawLogBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.invite,
      page: () => const UserInviteView(),
      binding: UserInviteBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.userSign,
      page: () => const UserSignView(),
      binding: UserSignBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.userRights,
      page: () => const UserRightsView(),
      binding: UserRightsBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.inviteHistory,
      page: () => const InviteHistoryView(),
      binding: InviteHistoryBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const UserSettingView(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.focus,
      page: () => const FocusCenterView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AppAboutView(),
    ),
    GetPage(
      name: AppRoutes.help,
      page: () => const AppHelpView(),
      binding: AppHelpBinding(),
    ),
    GetPage(
      name: AppRoutes.message,
      page: () => const MessageCenterView(),
      binding: MessageCenterBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.channelMessage,
      page: () => const ChannelMessageView(),
      binding: ChannelMessageBindings(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.channelSetting,
      page: () => const ChannelSettingView(),
      transition: Transition.rightToLeft,
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.kefuContact,
      page: () => const KefuContactView(),
      binding: KefuContactBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.feedback,
      page: () => const AppFeedbackView(),
      binding: AppFeedbackBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.newsBillboard,
      page: () => const NewsBillboardView(),
      binding: NewsBillboardBindings(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const SportNewsView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.topicDetail,
      page: () => const NewsTopicView(),
      binding: NewsTopicBindings(),
    ),
    GetPage(
      name: AppRoutes.usage,
      page: () => const UsageProtocolView(),
    ),
    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyProtocolView(),
    ),
    GetPage(
      name: AppRoutes.beian,
      page: () => const BeiAnMiitView(),
    ),
    GetPage(
      name: AppRoutes.permission,
      page: () => const PermissionView(),
    ),
    GetPage(
      name: AppRoutes.credential,
      page: () => const CredentialQualityView(),
    ),
    GetPage(
      name: AppRoutes.schemeList,
      page: () => const SchemeListView(),
    ),
    GetPage(
      name: AppRoutes.schemeDetail,
      page: () => const SchemeDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.schemeHistory,
      transition: Transition.rightToLeft,
      page: () => const SchemeHistoryView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.matchDetail,
      page: () => const MatchDetailView(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.matchFilter,
      page: () => const MatchFilterView(),
    ),
    GetPage(
      name: AppRoutes.matchSetting,
      transition: Transition.rightToLeft,
      page: () => const MatchSettingView(),
    ),
    GetPage(
      name: AppRoutes.areaCountry,
      page: () => const AreaCountryView(),
    ),
    GetPage(
      name: AppRoutes.countryLeague,
      page: () => const CountryLeagueView(),
      binding: CountryLeagueBinding(),
    ),
    GetPage(
      name: AppRoutes.leagueDetail,
      page: () => const LeagueDetailView(),
      binding: LeagueDetailBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.teamDetail,
      page: () => const TeamCenterView(),
      binding: TeamCenterBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const LeagueSearchView(),
      transition: Transition.rightToLeft,
      binding: LeagueSearchBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.browseRecord,
      page: () => const BrowseRecordView(),
      binding: BrowseRecordBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.bigSmallStats,
      page: () => const StatBigSmallView(),
      binding: StatBigSmallBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.halfAllStats,
      page: () => const StatsHalfAllView(),
      binding: StatHalfAllBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.oddsEvenStats,
      page: () => const StatsOddsEvenView(),
      binding: StatOddsEvenBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.pointGoalStats,
      page: () => const StatsPointGoalView(),
      binding: StatPointGoalBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.winLossStats,
      page: () => const StatsWinLossView(),
      binding: StatWinLossBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.matchResult,
      page: () => const HomeResultView(),
    ),
    GetPage(
      name: AppRoutes.matchFocus,
      page: () => const HomeFocusView(),
    ),
    GetPage(
      name: AppRoutes.leagueMatchSchedule,
      page: () => const LeagueScheduleView(),
    ),
  ];
}
