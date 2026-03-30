// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_transactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filteredTransactions)
final filteredTransactionsProvider = FilteredTransactionsProvider._();

final class FilteredTransactionsProvider
    extends
        $FunctionalProvider<
          List<TransactionModel>,
          List<TransactionModel>,
          List<TransactionModel>
        >
    with $Provider<List<TransactionModel>> {
  FilteredTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<TransactionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TransactionModel> create(Ref ref) {
    return filteredTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionModel>>(value),
    );
  }
}

String _$filteredTransactionsHash() =>
    r'44ac15d99dfa4cba93071c0583760d01f5917e80';
