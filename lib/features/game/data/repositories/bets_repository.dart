import 'package:hari_tari/core/services/api_client.dart';
import 'package:hari_tari/features/game/data/models/bet_item.dart';
import 'package:hari_tari/features/game/data/models/bet_item_rm.dart';
import 'package:hari_tari/utils/mocks.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class BetsRepository {
  final DioClient _dioClient;

  BetsRepository(this._dioClient);

  Future<BetItemRm> getCurrentBets() async {
    try {
      final response = await _dioClient.post('/api/bet/current-bets');
      return BetItemRm.fromJson(response.data);
    } catch (e) {
      logger.w('API failed, using mock bets instead. Error: $e');
      return BetItemRm.fromJson(mockBets);
    }
  }

  Future<bool> placeBet(BetItem betItem, int roundId) async {
    try {
      var body = {
        'roundId': roundId,
        'headsBet': betItem.headsBet,
        'tailsBet': betItem.tailsBet,
        'coinsResult': betItem.coinsResult.toJson(),
      };
      final response = await _dioClient.post('/api/bet', body: body);
      final data = response.data;
      return data['message'] == 'Success';
    } catch (e) {
      throw Exception('Error in placing bet: $e');
    }
  }
}
