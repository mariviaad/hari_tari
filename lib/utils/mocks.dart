import 'dart:math';

final random = Random();

String randomCoin() => random.nextBool() ? "heads" : "tails";

final mockResults = {
  "results": List.generate(500, (index) {
    final coins = [randomCoin(), randomCoin(), randomCoin()];
    final heads = coins.where((c) => c == "heads").length;
    final winner = heads > 1 ? "heads" : "tails";

    return {
      "roundNum": index + 1,
      "raceTime": DateTime.now()
          .subtract(Duration(minutes: index))
          .toIso8601String(),
      "coinsResult": {
        "coin1": coins[0],
        "coin2": coins[1],
        "coin3": coins[2],
        "winner": winner,
      },
    };
  }),
};

int randomBet() {
  final options = [0, random.nextInt(196) + 5];
  return options[random.nextInt(options.length)];
}

final Map<String, dynamic> mockBets = {
  "bets": List.generate(100, (index) {
    final coins = [randomCoin(), randomCoin(), randomCoin()];
    final heads = coins.where((c) => c.toUpperCase() == "HEADS").length;
    final winner = heads > 1 ? "HEADS" : "TAILS";

    return {
      "roundNum": 100 - index,
      "raceTime": DateTime.now()
          .subtract(Duration(minutes: index * 5))
          .toIso8601String(),
      "headsBet": randomBet(),
      "tailsBet": randomBet(),
      "coinsResult": {
        "coin1": coins[0],
        "coin2": coins[1],
        "coin3": coins[2],
        "winner": winner,
      },
    };
  }),
};
