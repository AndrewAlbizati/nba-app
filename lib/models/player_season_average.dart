class PlayerSeasonAverage {
  late int gamesPlayed;
  late int playerId;
  late int season;
  late String min;

  late double fgm;
  late double fga;
  late double fg3m;
  late double fg3a;
  late double ftm;
  late double fta;
  late double oreb;
  late double dreb;
  late double reb;
  late double ast;
  late double stl;
  late double blk;
  late double turnover;
  late double pf;
  late double pts;
  late double fg_pct;
  late double fg3_pct;
  late double ft_pct;

  PlayerSeasonAverage({
    required this.gamesPlayed,
    required this.playerId,
    required this.season,
    required this.min,
    required this.fgm,
    required this.fga,
    required this.fg3m,
    required this.fg3a,
    required this.ftm,
    required this.fta,
    required this.oreb,
    required this.dreb,
    required this.reb,
    required this.ast,
    required this.stl,
    required this.blk,
    required this.turnover,
    required this.pf,
    required this.pts,
    required this.fg_pct,
    required this.fg3_pct,
    required this.ft_pct,
  });

  PlayerSeasonAverage.empty();

  PlayerSeasonAverage.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    playerId = json['player_id'];
    season = json['season'];
    min = json['min'];
    fgm = json['fgm'];
    fga = json['fga'];
    fg3m = json['fg3m'];
    fg3a = json['fg3a'];
    ftm = json['ftm'];
    fta = json['fta'];
    oreb = json['oreb'];
    dreb = json['dreb'];
    reb = json['reb'];
    ast = json['ast'];
    stl = json['stl'];
    blk = json['blk'];
    turnover = json['turnover'];
    pf = json['pf'];
    pts = json['pts'];
    fg_pct = json['fg_pct'];
    fg3_pct = json['fg3_pct'];
    ft_pct = json['ft_pct'];
  }
}
