import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/bloc/betting/betting_cubit.dart';
import 'package:hari_tari/features/game/presentation/bloc/betting/betting_state.dart';

class TailsBetWidget extends StatelessWidget {
  const TailsBetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1000;
    final double fontsizelg = screenWidth <= 600 ? 14 : 17.5;

    return BlocBuilder<BettingCubit, BettingState>(
      builder: (context, state) {
        final betAmount = state.betAmount;
        final totalTails = state.totalTailsBet;
        final yourTailsBet = state.yourTailsBet;

        // Calculate win chance
        final totalPool = state.totalHeadsBet + state.totalTailsBet;
        final winChance = totalPool > 0
            ? ((totalTails / totalPool) * 100).toStringAsFixed(0)
            : "0";

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(130, 24, 26, .20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromRGBO(251, 44, 54, 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(251, 44, 54, .25),
                blurRadius: 10,
                spreadRadius: 1,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "TAILS",
                style: TextStyle(
                  fontSize: fontsizelg,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(255, 162, 162, 1),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: DottedBorder(
                      options: CircularDottedBorderOptions(
                        dashPattern: [6, 4],
                        strokeWidth: 2,
                        color: const Color.fromRGBO(248, 98, 101, 1),
                        padding: const EdgeInsets.all(0),
                      ),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: const Color.fromRGBO(130, 24, 26, .30),
                        child: const Text(
                          "T",
                          style: TextStyle(
                            fontSize: 12.25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 162, 162, 1),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 14),

              Text(
                "₱$totalTails", // dynamic pool amount
                style: TextStyle(
                  fontSize: fontsizelg,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "$winChance%", // dynamic win chance
                style: const TextStyle(
                  fontSize: 13.75,
                  color: Color.fromRGBO(255, 100, 103, 1),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your Bet: ",
                    style: TextStyle(
                      fontSize: 12.25,
                      color: Color.fromRGBO(255, 100, 103, 1),
                    ),
                  ),
                  Text(
                    "₱$yourTailsBet",
                    style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellow,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return const Color.fromRGBO(251, 44, 54, 0.4);
                      }
                      return const Color.fromRGBO(231, 0, 11, 1);
                    }),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: isSmallScreen ? 12 : 14),
                    ),
                  ),
                  onPressed: (yourTailsBet + betAmount > 200)
                      ? null
                      : () {
                          context.read<BettingCubit>().placeTailsBet();
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (yourTailsBet + betAmount > 200) ? "MAX BET" : "BET ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.25,
                        ),
                      ),
                      if (yourTailsBet + betAmount <= 200)
                        Text(
                          "₱$betAmount",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.25,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              if (yourTailsBet + betAmount > 200)
                const Text(
                  "Would exceed maximum bet",
                  style: TextStyle(
                    color: Color.fromRGBO(153, 161, 175, 1),
                    fontSize: 10.5,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
