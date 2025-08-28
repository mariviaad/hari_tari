import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hari_tari/features/game/data/models/result.dart';
import 'package:hari_tari/features/game/data/repositories/result_repository.dart';

part 'result_hist_state.dart';
part 'result_hist_event.dart';

class ResultHistoryBloc extends Bloc<ResultHistoryEvent, ResultHistoryState> {
  final ResultRepository resultsRepository;
  ResultHistoryBloc(this.resultsRepository) : super(InitialResultHistory()) {
    on<FetchResultHistory>(_fetchBets);
  }

  void _fetchBets(FetchResultHistory event, emit) async {
    emit(ResultHistoryLoading());
    try {
      final results = await resultsRepository.fetchRaceHistory();
      emit(ResultHistoryLoaded(resultList: results.results));
    } catch (error) {
      emit(ErrorResultHistory(errorMessage: error.toString()));
    }
  }
}
