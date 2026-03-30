import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final options = BaseOptions(
    method: 'POST',
    headers: {
      "x-goog-api-key": dotenv.env['API_KEY'] as String,
    },
    contentType: 'application/json'
  );
  return Dio(
    options
  );
}