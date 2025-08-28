import 'package:hari_tari/core/services/api_client.dart';
import 'package:hari_tari/features/game/data/models/result_rm.dart';
import 'package:hari_tari/utils/mocks.dart';

class ResultRepository {
  final DioClient _dioClient;

  ResultRepository(this._dioClient);
  Future<ResultRm> fetchRaceHistory() async {
    try {
      final response = await _dioClient.get('/api/result/paged-list');
      //return ResultRm.fromJson(response.data);
      return ResultRm.fromJson(mockResults);
    } catch (e) {
      throw Exception('Error fetching results $e');
    }
  }
}
