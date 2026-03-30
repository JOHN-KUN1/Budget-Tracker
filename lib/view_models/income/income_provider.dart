import 'package:budget_tracker/models/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../transaction/transaction_provider.dart';

part 'income_provider.g.dart';


@riverpod
int income(Ref ref) {
  final transactions = ref.watch(transactionProvider);
  int incomeSum = 0;
  for (final item in transactions){
    if (item.transactionType == TransactionType.income){
      incomeSum += item.amount.toInt();
    }
  }
  return incomeSum;
}