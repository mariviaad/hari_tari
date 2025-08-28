import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/bloc/current_bets/current_bets_bloc.dart';
import 'package:hari_tari/features/game/data/models/bet_item.dart';

class YourBets extends StatelessWidget {
  const YourBets({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> columnHeaders = [
      "Time\nRound",
      "HEADS\nBet",
      "TAILS\nBet",
      "Result\nWinner",
      "Win\nAmount",
    ];

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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(49, 65, 88, .4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: List.generate(columnHeaders.length, (index) {
                      final header = columnHeaders[index];

                      TextAlign align;
                      if (index == 0) {
                        align = TextAlign.start;
                      } else if (index == columnHeaders.length - 1) {
                        align = TextAlign.end;
                      } else {
                        align = TextAlign.center;
                      }

                      if (header.contains("HEADS") ||
                          header.contains("TAILS")) {
                        final isHeads = header.contains("HEADS");
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            child: RichText(
                              textAlign: align,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: isHeads ? "HEADS" : "TAILS",
                                    style: TextStyle(
                                      color: isHeads ? Colors.blue : Colors.red,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "\nBet",
                                    style: TextStyle(
                                      color: Color.fromRGBO(209, 213, 220, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          child: Text(
                            header,
                            style: const TextStyle(
                              color: Color.fromRGBO(209, 213, 220, 1),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: align,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Text(
                                "${bet.raceTime.hour}:${bet.raceTime.minute.toString().padLeft(2, '0')}\n#${bet.roundNum}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
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
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (bet.headsBet > 0)
                                  Text(
                                    bet.coinsResult.winner == "HEADS"
                                        ? "WIN"
                                        : "LOSE",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: bet.coinsResult.winner == "HEADS"
                                          ? Colors.green
                                          : Colors.red,
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
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (bet.tailsBet > 0)
                                  Text(
                                    bet.coinsResult.winner == "TAILS"
                                        ? "WIN"
                                        : "LOSE",
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: bet.coinsResult.winner == "TAILS"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "${[bet.coinsResult.coin1, bet.coinsResult.coin2, bet.coinsResult.coin3].map((c) => c.toUpperCase().startsWith('H') ? 'H' : 'T').join('-')}\n${bet.coinsResult.winner.toUpperCase()}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              bet.winAmount != null
                                  ? "₱${bet.winAmount}"
                                  : "₱0",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.end,
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
