import 'dart:convert';

import 'package:budget_tracker/models/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../shared_pref/shared_preferences_provider.dart';

part 'transaction_provider.g.dart';

@riverpod
class Transaction extends _$Transaction {
  @override
  List<TransactionModel> build() {
    return getAllTransactions();
  }

  List<TransactionModel> getAllTransactions(){
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedTransactions = prefs.getStringList('allDbTransactions') ?? [];
    final transactions = savedTransactions.map((item) => TransactionModel.fromJson(jsonDecode(item))).toList();
    return transactions;
  }

  Future<void> addTransactions({
    required TransactionType transactionType,
    required String title,
    required double amount,
    required DateTime date,
    required Category category,
    required String note
  }) async {
    state = [
      ...state,
      TransactionModel.add(transactionType: transactionType, title: title, amount: amount, date: date, category: category, note: note)
    ].reversed.toList();
    await saveToDatabase();
  }

  Future<void> deleteTransaction({required String id}) async {
    state = state.where((elem) => elem.id != id).toList();
    await saveToDatabase();
  }

  Future<void> saveToDatabase() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final transactions = state.map((elem) => jsonEncode(elem.toJson())).toList();
    await prefs.setStringList('allDbTransactions', transactions);
  }
}

