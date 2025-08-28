part of 'current_bets_bloc.dart';

abstract class CurrentBetsEvent {}

class FetchCurrentBets extends CurrentBetsEvent {}

class AddNewBet extends CurrentBetsEvent {
  final BetItem betItem;

  AddNewBet({required this.betItem});
}
