///
///
class FeatureWinLose {
  late int played;
  late double win;
  late double draw;
  late double lose;

  FeatureWinLose.fromJson(Map<String, dynamic> json) {
    played = json['played'] ?? 0;
    win = json['win'] ?? 0;
    draw = json['draw'] ?? 0;
    lose = json['lose'] ?? 0;
  }
}

///
class FeatureBigSmall {
  late int played;
  late double big;
  late double go;
  late double small;

  FeatureBigSmall.fromJson(Map<String, dynamic> json) {
    played = json['played'] ?? 0;
    big = json['big'] ?? 0;
    go = json['go'] ?? 0;
    small = json['small'] ?? 0;
  }
}

///
class FeatureUpDown {
  late int played;
  late double up;
  late double go;
  late double down;

  FeatureUpDown.fromJson(Map<String, dynamic> json) {
    played = json['played'] ?? 0;
    up = json['up'] ?? 0;
    go = json['go'] ?? 0;
    down = json['down'] ?? 0;
  }
}
