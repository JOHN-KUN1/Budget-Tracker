
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../expense/expense_provider.dart';
import '../income/income_provider.dart';

part 'balance_provider.g.dart';

@riverpod
int balance(Ref ref) {
  final income = ref.watch(incomeProvider);
  final expense = ref.watch(expenseProvider);
  return  income - expense;
}