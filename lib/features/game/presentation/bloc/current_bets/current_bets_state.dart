part of 'current_bets_bloc.dart';

abstract class CurrentBetsState {}

class InitialCurrentBets extends CurrentBetsState {}

class CurrentBetsLoading extends CurrentBetsState {}

class CurrentBetsLoaded extends CurrentBetsState {
  final List<BetItem> betItems;

  CurrentBetsLoaded({required this.betItems});
}

class CurrentBetsLoadingMore extends CurrentBetsLoaded {
  CurrentBetsLoadingMore({required super.betItems});
}

class BetSuccessful extends CurrentBetsLoaded {
  final double headsBet;
  final double tailsBet;
  BetSuccessful({
    required super.betItems,
    required this.headsBet,
    required this.tailsBet,
  });
}

class PlaceBetFailed extends CurrentBetsLoaded {
  final String errorMessage;

  PlaceBetFailed({required super.betItems, required this.errorMessage});
}

class ErrorCurrentBets extends CurrentBetsState {
  final String errorMessage;

  ErrorCurrentBets({required this.errorMessage});
}
