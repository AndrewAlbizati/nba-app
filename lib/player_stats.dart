class PlayerStats {
  late int statsId;
  late int ast;
  late int blk;
  late int dreb;
  late double fg3_pct;
  late int fg3a;
  late int fg3m;
  late double fg_pct;
  late int fga;
  late int fgm;
  late double ft_pct;
  late int fta;
  late int ftm;
  late String min;
  late int oreb;
  late int pf;
  late int pts;
  late int reb;
  late int stl;
  late int turnover;

  late int teamId;
  late int playerId;
  late String firstName;
  late String lastName;

  PlayerStats({
    required this.statsId,
    required this.ast,
    required this.blk,
    required this.dreb,
    required this.fg3_pct,
    required this.fg3a,
    required this.fg3m,
    required this.fg_pct,
    required this.fga,
    required this.fgm,
    required this.ft_pct,
    required this.fta,
    required this.ftm,
    required this.min,
    required this.oreb,
    required this.pf,
    required this.pts,
    required this.reb,
    required this.stl,
    required this.turnover,
    required this.playerId,
    required this.teamId,
    required this.firstName,
    required this.lastName,
  });

  PlayerStats.fromJson(Map<String, dynamic> json) {
    statsId = json['id'];
    ast = json['ast'];
    blk = json['blk'];
    dreb = json['dreb'];
    fg3_pct = json['fg3_pct'];
    fg3a = json['fg3a'];
    fg3m = json['fg3m'];
    fg_pct = json['fg_pct'];
    fga = json['fga'];
    fgm = json['fgm'];
    ft_pct = json['ft_pct'];
    fta = json['fta'];
    ftm = json['ftm'];
    min = json['min'];
    oreb = json['oreb'];
    pf = json['pf'];
    pts = json['pts'];
    reb = json['reb'];
    stl = json['stl'];
    turnover = json['turnover'];

    playerId = json['player']['id'];
    teamId = json['team']['id'];
    firstName = json['player']['first_name'];
    lastName = json['player']['last_name'];
  }
}
