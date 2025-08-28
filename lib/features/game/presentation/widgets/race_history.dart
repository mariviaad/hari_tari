import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/features/game/presentation/bloc/result_history/result_hist_bloc.dart';

class RaceHistory extends StatefulWidget {
  const RaceHistory({super.key});

  @override
  State<RaceHistory> createState() => _RaceHistoryState();
}

class _RaceHistoryState extends State<RaceHistory> {
  final ScrollController _scrollController = ScrollController();

  int selectedQuantity = 100;
  int? highlightedValue;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const rowsPerColumn = 5;
    const cellSize = 21.0;
    const spacing = 6.0;

    return BlocBuilder<ResultHistoryBloc, ResultHistoryState>(
      builder: (context, state) {
        if (state is ResultHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorResultHistory) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is ResultHistoryLoaded) {
          final results = state.resultList.take(selectedQuantity).toList();

          final int columnCount = (results.length / rowsPerColumn).ceil();
          final List<List<String>> columns = List.generate(columnCount, (col) {
            final start = col * rowsPerColumn;
            final end = (start + rowsPerColumn).clamp(0, results.length);
            return results
                .sublist(start, end)
                .map((r) => r.coinsResult.winner)
                .toList();
          });

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(29, 41, 61, 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  "RECENT RESULTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    const Spacer(),
                    DropdownButton<int>(
                      value: selectedQuantity,
                      dropdownColor: Colors.black87,
                      style: const TextStyle(color: Colors.white),
                      items: const [
                        DropdownMenuItem(value: 50, child: Text("50")),
                        DropdownMenuItem(value: 100, child: Text("100")),
                        DropdownMenuItem(value: 250, child: Text("250")),
                        DropdownMenuItem(value: 500, child: Text("500")),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedQuantity = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Container(
                  alignment: Alignment.topLeft,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    thickness: 8,
                    radius: const Radius.circular(8),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: columns.map((colResults) {
                            return Padding(
                              padding: const EdgeInsets.only(right: spacing),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: colResults.map((winner) {
                                  final isHeads = winner == "heads";
                                  final color = isHeads
                                      ? Colors.blue
                                      : Colors.red;
                                  final isHighlighted =
                                      highlightedValue == null ||
                                      highlightedValue == (isHeads ? 0 : 1);

                                  return AnimatedContainer(
                                    width: cellSize,
                                    height: cellSize,
                                    margin: const EdgeInsets.only(
                                      bottom: spacing,
                                    ),
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: isHighlighted
                                          ? color
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
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
