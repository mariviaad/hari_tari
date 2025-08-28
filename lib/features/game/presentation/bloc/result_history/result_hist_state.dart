part of 'result_hist_bloc.dart';

abstract class ResultHistoryState {}

class InitialResultHistory extends ResultHistoryState {}

class ResultHistoryLoading extends ResultHistoryState {
  ResultHistoryLoading();
}

class ResultHistoryLoadMore extends ResultHistoryState {
  final List<Result> oldData;

  ResultHistoryLoadMore({required this.oldData});
}

class ResultHistoryLoaded extends ResultHistoryState {
  final List<Result> resultList;

  ResultHistoryLoaded({required this.resultList});
}

class ErrorResultHistory extends ResultHistoryState {
  final String errorMessage;

  ErrorResultHistory({required this.errorMessage});
}
