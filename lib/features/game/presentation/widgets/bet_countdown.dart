import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hari_tari/core/theme/constants/colors_const.dart';

class BetCountdown extends StatefulWidget {
  final VoidCallback onCountdownFinish;
  const BetCountdown({super.key, required this.onCountdownFinish});

  @override
  State<BetCountdown> createState() => _BetCountdownState();
}

enum CountdownState {
  openGreen,
  openYellow,
  finalSeconds,
  closingSoon,
  drawingHands,
  results,
}

class _BetCountdownState extends State<BetCountdown> {
  int secondsLeft = 60;
  CountdownState currentState = CountdownState.openGreen;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();
    secondsLeft = 60;
    currentState = CountdownState.openGreen;

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
          updateState();
        } else {
          t.cancel();
          startDrawingHands();
        }
      });
    });
  }

  void startDrawingHands() {
    setState(() {
      currentState = CountdownState.drawingHands;
      secondsLeft = 10;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else {
          t.cancel();
          startResults();
        }
      });
    });
  }

  void startResults() {
    setState(() {
      currentState = CountdownState.results;
      secondsLeft = 5;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else {
          t.cancel();
          widget.onCountdownFinish();
          startCountdown();
        }
      });
    });
  }

  void updateState() {
    if (secondsLeft <= 5) {
      currentState = CountdownState.closingSoon;
    } else if (secondsLeft <= 10) {
      currentState = CountdownState.finalSeconds;
    } else if (secondsLeft <= 30) {
      currentState = CountdownState.openYellow;
    } else {
      currentState = CountdownState.openGreen;
    }
  }

  Color getBackgroundColor() {
    switch (currentState) {
      case CountdownState.openGreen:
        return Color.fromRGBO(0, 166, 62, 1);
      case CountdownState.openYellow:
        return Color.fromRGBO(166, 95, 0, 1);
      case CountdownState.finalSeconds:
        return Color.fromRGBO(245, 74, 0, 1);
      case CountdownState.closingSoon:
        return Color.fromRGBO(231, 0, 11, 1);
      case CountdownState.drawingHands:
        return Color.fromRGBO(21, 39, 252, 1);
      case CountdownState.results:
        return Color.fromRGBO(208, 135, 0, 1);
    }
  }

  Color getBorderColor() {
    switch (currentState) {
      case CountdownState.openGreen:
        return Color.fromRGBO(0, 201, 81, 1);
      case CountdownState.openYellow:
        return Color.fromRGBO(208, 135, 0, 1);
      case CountdownState.finalSeconds:
        return Color.fromRGBO(255, 105, 0, 1);
      case CountdownState.closingSoon:
        return Color.fromRGBO(251, 44, 54, 1);
      case CountdownState.drawingHands:
        return Color.fromRGBO(43, 127, 255, 1);
      case CountdownState.results:
        return Color.fromRGBO(240, 177, 0, 1);
    }
  }

  String getLabel() {
    switch (currentState) {
      case CountdownState.openGreen:
        return "OPEN";
      case CountdownState.openYellow:
        return "OPEN";
      case CountdownState.finalSeconds:
        return "FINAL SECONDS";
      case CountdownState.closingSoon:
        return "CLOSING SOON";
      case CountdownState.drawingHands:
        return "DRAWING HANDS";
      case CountdownState.results:
        return "RESULTS";
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: getBackgroundColor(),
            border: Border.all(color: getBorderColor(), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Center(
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 12),
                  const SizedBox(width: 6),
                  Text(
                    getLabel(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$secondsLeft",
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (currentState == CountdownState.drawingHands) ...[
          const SizedBox(height: 4),
          const Text(
            "Flipping Coins...",
            style: TextStyle(
              fontSize: 12.25,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ],
    );
  }
}
