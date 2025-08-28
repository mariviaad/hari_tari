import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final int roundNum;
  final DateTime raceTime;
  final CoinsResult coinsResult;

  const Result({
    required this.roundNum,
    required this.raceTime,
    required this.coinsResult,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      roundNum: json["roundNum"],
      raceTime: DateTime.parse(json["raceTime"]),
      coinsResult: CoinsResult.fromJson(json["coinsResult"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "roundNum": roundNum,
      "raceTime": raceTime.toIso8601String(),
      "coinsResult": coinsResult.toJson(),
    };
  }

  @override
  List<Object?> get props => [roundNum, raceTime, coinsResult];
}

class CoinsResult extends Equatable {
  final String coin1;
  final String coin2;
  final String coin3;
  final String? winnerFromJson; // optional winner field from backend

  const CoinsResult({
    required this.coin1,
    required this.coin2,
    required this.coin3,
    this.winnerFromJson,
  });

  factory CoinsResult.fromJson(Map<String, dynamic> json) {
    return CoinsResult(
      coin1: json["coin1"],
      coin2: json["coin2"],
      coin3: json["coin3"],
      winnerFromJson: json["winner"], // may or may not exist
    );
  }

  List<String> get coins => [coin1, coin2, coin3];

  /// Use backend winner if given, otherwise compute
  String get winner {
    if (winnerFromJson != null) return winnerFromJson!;
    final heads = coins.where((c) => c == "heads").length;
    final tails = 3 - heads;
    return heads > tails ? "heads" : "tails";
  }

  Map<String, dynamic> toJson() {
    return {"coin1": coin1, "coin2": coin2, "coin3": coin3, "winner": winner};
  }

  @override
  List<Object?> get props => [coin1, coin2, coin3, winnerFromJson];
}
