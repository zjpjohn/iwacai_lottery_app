///
///
class AppRoutes {
  ///
  /// 错误页面
  ///
  static const notFound = '/404';
  static const serverError = '/500';

  ///
  /// 授权登录页面
  ///
  static const login = '/login';

  ///
  /// 业务页面
  ///
  static const main = '/main';
  static const invite = '/invite';
  static const inviteHistory = '/invite/history';
  static const feedback = '/feedback';
  static const help = '/help';
  static const account = '/account';
  static const accountAbout = '/account/about';
  static const balance = '/balance/:index';
  static const voucher = '/voucher';
  static const voucherDraw = '/voucher/draw';
  static const consume = '/consume';
  static const exchange = '/exchange';
  static const withdraw = '/withdraw';
  static const focus = '/focus';
  static const about = '/about';
  static const message = '/message';
  static const channelMessage = '/channel/message';
  static const channelSetting = '/channel/setting';
  static const splash = '/splash';
  static const usage = '/usage';
  static const reset = '/reset';
  static const privacy = '/privacy';
  static const beian = '/beian';
  static const permission = '/permission';
  static const credential = '/credential';
  static const settings = '/settings';
  static const search = '/search';
  static const topicDetail = '/topic/:topicId';
  static const newsDetail = '/news/:newsId';
  static const newsBillboard = '/news/billboard';
  static const schemeList = '/scheme/list';
  static const schemeDetail = '/scheme/:seqNo';
  static const schemeHistory = '/scheme/history/:expertNo';
  static const matchResult = '/home/result';
  static const matchFocus = '/home/focus';
  static const matchDetail = '/match/:matchId';
  static const matchFilter = '/filter/:type';
  static const matchSetting = '/setting';
  static const areaCountry = '/area/:area';
  static const leagueDetail = '/league/:leagueId';
  static const leagueMatchSchedule = '/league/schedule/:leagueId';
  static const countryLeague = '/country/league/:countryId';
  static const teamDetail = '/team/:leagueId/:teamId';
  static const browseRecord = '/browse';
  static const kefuContact = '/kefu';
  static const userSign = '/sign';
  static const userRights = '/rights';

  ///统计页面
  static const bigSmallStats = '/bigAndSmall/:seasonId';
  static const commonGoalStats = '/commonGoal/:seasonId';
  static const halfAllStats = '/halfAll/:seasonId';
  static const oddsEvenStats = '/oddsEven/:seasonId';
  static const pointGoalStats = '/pointGoal/:seasonId';
  static const teamTapeStats = '/teamTape/:seasonId';
  static const winLossStats = '/winLoss/:seasonId';
}
