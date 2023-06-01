import 'package:get_it/get_it.dart';
import 'package:protofac/services/analytics_service.dart';
import 'package:protofac/services/auth_service.dart';
import 'package:protofac/services/user_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => AnalyticsService());
}
