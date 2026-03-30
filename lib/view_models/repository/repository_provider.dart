import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/ai_repository.dart';
import '../api/api_service_provider.dart';


part 'repository_provider.g.dart';

@riverpod
AiRepository aiRepository(Ref ref) {
  return AiRepository(apiService: ref.watch(apiServiceProvider));
}