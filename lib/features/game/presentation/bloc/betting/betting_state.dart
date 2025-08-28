enum BettingPhase { open, closingSoon, drawingHands, results }

class BettingState {
  final int betAmount;
  final int yourHeadsBet;
  final int yourTailsBet;
  final int totalHeadsBet;
  final int totalTailsBet;
  final bool bettingOpen;
  final BettingPhase phase;

  const BettingState({
    required this.betAmount,
    required this.yourHeadsBet,
    required this.yourTailsBet,
    required this.totalHeadsBet,
    required this.totalTailsBet,
    required this.bettingOpen,
    required this.phase,
  });

  factory BettingState.initial() {
    return BettingState(
      betAmount: 5,
      yourHeadsBet: 0,
      yourTailsBet: 0,
      totalHeadsBet: 0,
      totalTailsBet: 0,
      bettingOpen: true,
      phase: BettingPhase.open,
    );
  }

  BettingState copyWith({
    int? betAmount,
    int? yourHeadsBet,
    int? yourTailsBet,
    int? totalHeadsBet,
    int? totalTailsBet,
    bool? bettingOpen,
    BettingPhase? phase,
  }) {
    return BettingState(
      betAmount: betAmount ?? this.betAmount,
      yourHeadsBet: yourHeadsBet ?? this.yourHeadsBet,
      yourTailsBet: yourTailsBet ?? this.yourTailsBet,
      totalHeadsBet: totalHeadsBet ?? this.totalHeadsBet,
      totalTailsBet: totalTailsBet ?? this.totalTailsBet,
      bettingOpen: bettingOpen ?? this.bettingOpen,
      phase: phase ?? this.phase,
    );
  }
}
