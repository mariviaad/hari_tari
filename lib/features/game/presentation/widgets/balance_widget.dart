import 'package:flutter/material.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/widgets/hover_text_button.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: width <= 1000
          ? EdgeInsets.symmetric(vertical: 10, horizontal: 12)
          : EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.buttonBlueGrey,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Text(
            "Balance:",
            style: TextStyle(color: AppColors.fontGrey, fontSize: 10.5),
          ),
          SizedBox(width: 4),
          Text(
            "₱1,250.75",
            style: TextStyle(
              color: AppColors.yellow,
              fontSize: 12.25,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8),
          HoverTextButton(text: "DEPOSIT", onTap: () {}),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: HoverTextIconButton(label: "HOW TO PLAY", onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
