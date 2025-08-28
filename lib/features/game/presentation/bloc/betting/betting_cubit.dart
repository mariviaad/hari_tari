import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/features/game/presentation/bloc/betting/betting_state.dart';

class BettingCubit extends Cubit<BettingState> {
  final int minBet;
  final int maxBet;

  BettingCubit({this.minBet = 5, this.maxBet = 200})
    : super(BettingState.initial());

  void updateBetAmount(int betAmount) {
    emit(state.copyWith(betAmount: betAmount));
  }

  void placeHeadsBet() {
    if (!state.bettingOpen) return;

    final newYourBet = (state.yourHeadsBet + state.betAmount).clamp(
      minBet,
      maxBet,
    );
    final newTotalHeads = state.totalHeadsBet + state.betAmount;

    emit(
      state.copyWith(yourHeadsBet: newYourBet, totalHeadsBet: newTotalHeads),
    );
  }

  void placeTailsBet() {
    if (!state.bettingOpen) return;

    final newYourBet = (state.yourTailsBet + state.betAmount).clamp(
      minBet,
      maxBet,
    );
    final newTotalTails = state.totalTailsBet + state.betAmount;

    emit(
      state.copyWith(yourTailsBet: newYourBet, totalTailsBet: newTotalTails),
    );
  }

  void setPhase(BettingPhase phase) {
    emit(
      state.copyWith(
        phase: phase,
        bettingOpen:
            phase == BettingPhase.open || phase == BettingPhase.closingSoon,
      ),
    );
  }
}
