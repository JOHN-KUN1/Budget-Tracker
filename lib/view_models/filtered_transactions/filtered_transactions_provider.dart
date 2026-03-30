import 'package:budget_tracker/view_models/search/search_provider.dart';
import 'package:budget_tracker/view_models/transaction/transaction_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/transaction_model.dart';

part 'filtered_transactions_provider.g.dart';

@riverpod
List<TransactionModel> filteredTransactions(Ref ref) {
  final transactions = ref.watch(transactionProvider);
  final searchTerm = ref.watch(searchProvider);

  if (searchTerm.isNotEmpty){
    List<TransactionModel> filterTransactions = transactions
        .where(
          (elem) =>
              elem.title.toLowerCase().contains(searchTerm.toLowerCase()),
        )
        .toList();
    return filterTransactions;
  }
  return transactions;
}
