import 'package:flutter/material.dart';

class YourBetsHeader extends StatelessWidget {
  const YourBetsHeader({super.key});

  final List<String> columnHeaders = const [
    "Time\nRound",
    "HEADS\nBet",
    "TAILS\nBet",
    "Result\nWinner",
    "Win\nAmount",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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

          if (header.contains("HEADS") || header.contains("TAILS")) {
            final isHeads = header.contains("HEADS");
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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

          // Default header
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
    );
  }
}
