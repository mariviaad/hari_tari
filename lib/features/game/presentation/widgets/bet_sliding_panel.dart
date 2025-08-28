import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/bloc/betting/betting_cubit.dart';
import 'package:hari_tari/features/game/presentation/widgets/balance_widget.dart';
import 'package:hari_tari/features/game/presentation/widgets/bet_amount_widget.dart';
import 'package:hari_tari/features/game/presentation/widgets/bet_countdown.dart';
import 'package:hari_tari/features/game/presentation/widgets/betting_widget.dart';
import 'package:hari_tari/features/game/presentation/widgets/history_menu.dart';

class BetSlidingPanel extends StatefulWidget {
  const BetSlidingPanel({super.key});

  @override
  State<BetSlidingPanel> createState() => BetSlidingPanelState();
}

class BetSlidingPanelState extends State<BetSlidingPanel> {
  final ScrollController _scrollController = ScrollController();

  get onCountdownFinish => null;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => BettingCubit(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.gameBackground),
        constraints: BoxConstraints(minHeight: 0, maxHeight: width * 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: width < 1000
                  ? EdgeInsets.symmetric(
                      horizontal: width * 0.025,
                      vertical: 14,
                    )
                  : EdgeInsets.all(16),
              child: BalanceWidget(),
            ),
            Expanded(
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(Color(0xFF9F9F9F)),
                  trackColor: WidgetStateProperty.all(Color(0xFF2C2C2C)),
                  trackBorderColor: WidgetStateProperty.all(Colors.transparent),
                  interactive: true,
                  radius: const Radius.circular(8),
                  thickness: WidgetStateProperty.all(10),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  interactive: true,
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: BetCountdown(
                              onCountdownFinish: onCountdownFinish ?? () {},
                            ),
                          ),
                          SizedBox(height: 10),
                          BettingWidget(),
                          SizedBox(height: 10),
                          BetAmountWidget(),
                          SizedBox(height: 10),
                          HistoryMenu(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
