import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/features/game/data/models/bet_item.dart';
import 'package:hari_tari/features/game/data/repositories/bets_repository.dart';

part 'current_bets_state.dart';
part 'current_bets_event.dart';

class CurrentBetsBloc extends Bloc<CurrentBetsEvent, CurrentBetsState> {
  final BetsRepository betsRepository;

  CurrentBetsBloc(this.betsRepository) : super(InitialCurrentBets()) {
    on<FetchCurrentBets>(_fetchBets);
    on<AddNewBet>(_addNewBet);
  }

  Future<void> _fetchBets(
    FetchCurrentBets event,
    Emitter<CurrentBetsState> emit,
  ) async {
    emit(CurrentBetsLoading());
    try {
      final betItems = await betsRepository.getCurrentBets();
      emit(CurrentBetsLoaded(betItems: betItems.bets));
    } catch (error) {
      emit(ErrorCurrentBets(errorMessage: error.toString()));
    }
  }

  Future<void> _addNewBet(
    AddNewBet event,
    Emitter<CurrentBetsState> emit,
  ) async {
    final currentState = state;

    List<BetItem> oldData = [];
    if (currentState is CurrentBetsLoaded) {
      oldData = List.from(currentState.betItems);
    }

    emit(CurrentBetsLoadingMore(betItems: oldData));
    try {
      final placeBet = await betsRepository.placeBet(event.betItem, 2);
      emit(
        BetSuccessful(
          betItems: placeBet ? [event.betItem, ...oldData] : oldData,
          headsBet: event.betItem.headsBet.toDouble(),
          tailsBet: event.betItem.tailsBet.toDouble(),
        ),
      );
    } catch (error) {
      emit(PlaceBetFailed(betItems: oldData, errorMessage: error.toString()));
    }
  }
}
