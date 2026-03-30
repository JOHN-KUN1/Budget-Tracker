// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(income)
final incomeProvider = IncomeProvider._();

final class IncomeProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  IncomeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomeHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return income(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$incomeHash() => r'74b189a88340c3bcd4681f59f84361d930eb7cee';
