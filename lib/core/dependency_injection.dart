import 'package:get_it/get_it.dart';
import 'package:hari_tari/core/services/api_client.dart';
import 'package:hari_tari/features/game/dependency_injection.dart';

final locator = GetIt.instance;

void setUpDependencies() async {
  locator.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: 'local host'),
  );
  setUpGameDependencies();
}
