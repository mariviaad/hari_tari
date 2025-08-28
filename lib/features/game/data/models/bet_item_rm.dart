import 'package:hari_tari/features/game/data/models/bet_item.dart';

class BetItemRm {
  final List<BetItem> bets;

  const BetItemRm({required this.bets});

  factory BetItemRm.fromJson(Map<String, dynamic> json) {
    return BetItemRm(
      bets:
          (json['bets'] as List<dynamic>?)
              ?.map((item) => BetItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}
