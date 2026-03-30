import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/api_service.dart';
import '../dio/dio_provider.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  return ApiService(dio: ref.watch(dioProvider));
}