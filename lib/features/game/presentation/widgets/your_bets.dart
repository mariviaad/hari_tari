import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/bloc/current_bets/current_bets_bloc.dart';
import 'package:hari_tari/features/game/data/models/bet_item.dart';
import 'package:hari_tari/features/game/presentation/widgets/your_bets_header.dart';

class YourBets extends StatelessWidget {
  const YourBets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentBetsBloc, CurrentBetsState>(
      builder: (context, state) {
        if (state is CurrentBetsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorCurrentBets) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: AppColors.textRed),
            ),
          );
        }
        if (state is CurrentBetsLoaded) {
          final sortedItems = [...state.betItems]
            ..sort((a, b) => b.raceTime.compareTo(a.raceTime));
          final recentItems = sortedItems.take(40).toList();

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(29, 41, 61, 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "YOUR BETS",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const YourBetsHeader(),
                const SizedBox(height: 6),

                Column(
                  children: List.generate(recentItems.length, (index) {
                    final BetItem bet = recentItems[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(49, 65, 88, 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsGeometry.directional(
                                start: 10,
                              ),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "${bet.raceTime.hour}:${bet.raceTime.minute.toString().padLeft(2, '0')}\n",
                                      style: const TextStyle(
                                        fontSize: 10.5,
                                        color: Color(0xFF99A1AF),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "#${bet.roundNum}",
                                      style: const TextStyle(
                                        fontSize: 10.5,
                                        color: Color(0xFF6A7282),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  bet.headsBet > 0 ? "₱${bet.headsBet}" : "₱0",
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: bet.headsBet == 0
                                        ? Color(0xFF4A5565)
                                        : Color(0xFF51A2FF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (bet.headsBet > 0)
                                  Text(
                                    bet.coinsResult.winner == "HEADS"
                                        ? "WIN"
                                        : "LOSE",
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: bet.coinsResult.winner == "HEADS"
                                          ? Color(0xFF05DF72)
                                          : Color(0xFFFF6467),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  bet.tailsBet > 0 ? "₱${bet.tailsBet}" : "₱0",
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: bet.tailsBet == 0
                                        ? Color(0xFF4A5565)
                                        : Color(0xFF51A2FF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (bet.tailsBet > 0)
                                  Text(
                                    bet.coinsResult.winner == "TAILS"
                                        ? "WIN"
                                        : "LOSE",
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: bet.coinsResult.winner == "TAILS"
                                          ? Color(0xFF05DF72)
                                          : Color(0xFFFF6467),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${[bet.coinsResult.coin1, bet.coinsResult.coin2, bet.coinsResult.coin3].map((c) => c.toUpperCase().startsWith('H') ? 'H' : 'T').join('-')}\n",
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      color: Color(0xFFD1D5DC),
                                    ),
                                  ),
                                  TextSpan(
                                    text: bet.coinsResult.winner.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: bet.coinsResult.winner == "HEADS"
                                          ? Color(0xFF51A2FF)
                                          : Color(0xFFFF6467),
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsGeometry.directional(end: 10),
                              child: Text(
                                bet.winAmount != 0 ? "₱${bet.winAmount}" : "₱0",
                                style: TextStyle(
                                  fontSize: 10.5,
                                  color: bet.winAmount == 0
                                      ? Color(0xFF4A5565)
                                      : Color.fromRGBO(5, 223, 114, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
