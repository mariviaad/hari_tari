import 'package:flutter/material.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/widgets/heads_bet_widget.dart';
import 'package:hari_tari/features/game/presentation/widgets/tails_bet_widget.dart';

class BettingWidget extends StatelessWidget {
  const BettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double fontsizelg;

    if (screenWidth <= 600) {
      fontsizelg = 14;
    } else {
      fontsizelg = 17.5;
    }

    return Container(
      width: double.infinity,
      padding: screenWidth <= 1000
          ? const EdgeInsets.symmetric(vertical: 10, horizontal: 8)
          : const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Text(
            "CHOOSE YOUR SIDE",
            style: TextStyle(
              fontSize: fontsizelg,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: HeadsBetWidget()),
              SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: Color(0xFF314158),
                child: Text(
                  "VS",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12.25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(child: TailsBetWidget()),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
