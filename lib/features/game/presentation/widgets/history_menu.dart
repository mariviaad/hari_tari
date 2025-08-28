import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/core/dependency_injection.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';
import 'package:hari_tari/features/game/presentation/bloc/current_bets/current_bets_bloc.dart';
import 'package:hari_tari/features/game/presentation/bloc/result_history/result_hist_bloc.dart';
import 'package:hari_tari/features/game/presentation/widgets/race_history.dart';
import 'package:hari_tari/features/game/presentation/widgets/your_bets.dart';

class HistoryMenu extends StatefulWidget {
  const HistoryMenu({super.key});

  @override
  HistoryMenuState createState() => HistoryMenuState();
}

class HistoryMenuState extends State<HistoryMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResultHistoryBloc>(
          create: (context) =>
              locator<ResultHistoryBloc>()..add(FetchResultHistory()),
        ),
        BlocProvider<CurrentBetsBloc>(
          create: (context) =>
              locator<CurrentBetsBloc>()..add(FetchCurrentBets()),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 31.5,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.gridBlueGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildTab("Race History", 0),
                _buildTab("Your Bets", 1),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (selectedIndex == 0) RaceHistory() else YourBets(),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          height: 25.5,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.hoverGrey : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.25,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
