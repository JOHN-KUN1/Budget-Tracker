import 'package:budget_tracker/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpLocator(){
  getIt.registerLazySingleton<NavigationService>(() => NavigationService(),);
}