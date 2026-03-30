import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/transaction_model.dart';
import '../transaction/transaction_provider.dart';


part 'expense_provider.g.dart';

@riverpod
int expense(Ref ref) {
  final transactions = ref.watch(transactionProvider);
  int expenseSum = 0;
  for (final item in transactions){
    if (item.transactionType == TransactionType.expense){
      expenseSum += item.amount.toInt();
    }
  }
  return expenseSum;
}