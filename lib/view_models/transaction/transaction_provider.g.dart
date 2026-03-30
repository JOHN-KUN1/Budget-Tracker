// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Transaction)
final transactionProvider = TransactionProvider._();

final class TransactionProvider
    extends $NotifierProvider<Transaction, List<TransactionModel>> {
  TransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionHash();

  @$internal
  @override
  Transaction create() => Transaction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TransactionModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TransactionModel>>(value),
    );
  }
}

String _$transactionHash() => r'24f29a1d3df5fced0bcdf26bcee56f06eb114799';

abstract class _$Transaction extends $Notifier<List<TransactionModel>> {
  List<TransactionModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<TransactionModel>, List<TransactionModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TransactionModel>, List<TransactionModel>>,
              List<TransactionModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
