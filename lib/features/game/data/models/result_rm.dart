import 'package:hari_tari/features/game/data/models/result.dart';

class ResultRm {
  final List<Result> results;

  ResultRm({required this.results});

  factory ResultRm.fromJson(Map<String, dynamic> json) {
    return ResultRm(
      results:
          (json["results"] as List<dynamic>?)
              ?.map((item) => Result.fromJson(item))
              .toList() ??
          [],
    );
  }
}
