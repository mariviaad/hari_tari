import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/features/game/presentation/bloc/betting/betting_cubit.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/core/theme/constants/game_const.dart';
import 'package:flutter/material.dart';
import 'package:hari_tari/features/game/presentation/bloc/betting/betting_state.dart';

class BetAmountWidget extends StatefulWidget {
  const BetAmountWidget({super.key});

  @override
  State<BetAmountWidget> createState() => _BetAmountWidgetState();
}

class _BetAmountWidgetState extends State<BetAmountWidget> {
  int denomination = 1;

  void _increment() {
    final cubit = context.read<BettingCubit>();
    final newAmount =
        (cubit.state.betAmount + betDenominations[denomination].value)
            .clamp(5, 200)
            .toInt();
    cubit.updateBetAmount(newAmount);
  }

  void _decrement() {
    final cubit = context.read<BettingCubit>();
    final newAmount =
        (cubit.state.betAmount - betDenominations[denomination].value)
            .clamp(5, 200)
            .toInt();
    cubit.updateBetAmount(newAmount);
  }

  void _cycleDenomination() {
    setState(() {
      denomination = (denomination + 1) % betDenominations.length;
    });
  }

  Widget _buildClickableButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: enabled
              ? const Color.fromRGBO(69, 85, 108, 0.5)
              : const Color.fromRGBO(69, 85, 108, 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 14,
          weight: 3,
          color: enabled
              ? AppColors.white
              : const Color.fromRGBO(255, 255, 255, 0.1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BettingCubit, BettingState>(
      builder: (context, state) {
        final betAmount = state.betAmount;

        return Container(
          padding: const EdgeInsets.all(12),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: const Color.fromRGBO(49, 65, 88, .8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _cycleDenomination,
                child: Container(
                  width: 80,
                  height: 42,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(69, 85, 108, 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "+/- ${betDenominations[denomination].value}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "BET AMOUNT",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildClickableButton(
                    icon: Icons.remove,
                    onTap: _decrement,
                    enabled: betAmount > 5,
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 100,
                    height: 42,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(69, 85, 108, 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "₱$betAmount",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.75,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  _buildClickableButton(
                    icon: Icons.add,
                    onTap: _increment,
                    enabled: betAmount < 200,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
