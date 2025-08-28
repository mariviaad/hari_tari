import 'package:equatable/equatable.dart';

class BetItem extends Equatable {
  final int roundNum;
  final DateTime raceTime;
  final int headsBet;
  final int tailsBet;
  final CoinsResult coinsResult;

  const BetItem({
    required this.roundNum,
    required this.raceTime,
    required this.headsBet,
    required this.tailsBet,
    required this.coinsResult,
  });

  factory BetItem.fromJson(Map<String, dynamic> json) {
    return BetItem(
      roundNum: json["roundNum"] ?? 0,
      raceTime: DateTime.tryParse(json["raceTime"] ?? "") ?? DateTime.now(),
      headsBet: json['headsBet'] ?? 0,
      tailsBet: json['tailsBet'] ?? 0,
      coinsResult: CoinsResult.fromJson(json["coinsResult"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "roundNum": roundNum,
      "raceTime": raceTime.toIso8601String(),
      "headsBet": headsBet,
      "tailsBet": tailsBet,
      "coinsResult": coinsResult.toJson(),
      "winAmount": winAmount,
    };
  }

  int get winAmount {
    if (coinsResult.winner == "HEADS") {
      return headsBet * 5;
    } else {
      return tailsBet * 5;
    }
  }

  int get netEarnings {
    final totalBet = headsBet + tailsBet;
    return winAmount - totalBet;
  }

  @override
  List<Object?> get props => [
    roundNum,
    raceTime,
    headsBet,
    tailsBet,
    coinsResult,
  ];
}

class CoinsResult extends Equatable {
  final String coin1;
  final String coin2;
  final String coin3;
  final String? winnerFromJson;

  const CoinsResult({
    required this.coin1,
    required this.coin2,
    required this.coin3,
    this.winnerFromJson,
  });

  factory CoinsResult.fromJson(Map<String, dynamic> json) {
    return CoinsResult(
      coin1: (json["coin1"] ?? "").toString().toUpperCase(),
      coin2: (json["coin2"] ?? "").toString().toUpperCase(),
      coin3: (json["coin3"] ?? "").toString().toUpperCase(),
      winnerFromJson: (json["winner"] as String?)?.toUpperCase(),
    );
  }

  List<String> get coins => [coin1, coin2, coin3];

  String get winner {
    if (winnerFromJson != null) return winnerFromJson!;
    final heads = coins.where((c) => c == "HEADS").length;
    final tails = 3 - heads;
    return heads > tails ? "HEADS" : "TAILS";
  }

  Map<String, dynamic> toJson() {
    return {
      "coin1": coin1.toUpperCase(),
      "coin2": coin2.toUpperCase(),
      "coin3": coin3.toUpperCase(),
      "winner": (winnerFromJson ?? winner).toUpperCase(),
    };
  }

  @override
  List<Object?> get props => [coin1, coin2, coin3, winner];
}
