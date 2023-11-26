import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef RiverpodObserverDidAddProviderLog = void Function(
  ProviderBase<Object?> provider,
  Object? value,
  ProviderContainer container,
);

typedef RiverpodObserverDidDisposeProviderLog = void Function(
  ProviderBase<Object?> provider,
  ProviderContainer container,
);

typedef RiverpodObserverDidUpdateProvider = void Function(
  ProviderBase<Object?> provider,
  Object? previousValue,
  Object? newValue,
  ProviderContainer container,
);

typedef RiverpodObserverProviderDidFail = void Function(
  ProviderBase<Object?> provider,
  Object? error,
  StackTrace stackTrace,
  ProviderContainer container,
);

/// Implement TVBuddy Riverpod Provider Observer
class RiverpodObserver extends ProviderObserver {
  /// RiverpodObserverConstructor
  RiverpodObserver({
    this.didAddProviderLog,
    this.didDisposeProviderLog,
    this.didUpdateProviderLog,
    this.providerDidFailLog,
  });

  /// Log didAddProvider
  final RiverpodObserverDidAddProviderLog? didAddProviderLog;

  /// Log didDisposeProvider
  final RiverpodObserverDidDisposeProviderLog? didDisposeProviderLog;

  /// Log didUpdateProvider
  final RiverpodObserverDidUpdateProvider? didUpdateProviderLog;

  /// Log providerDidFailLog
  final RiverpodObserverProviderDidFail? providerDidFailLog;

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    didAddProviderLog?.call(
      provider,
      value,
      container,
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    didDisposeProviderLog?.call(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    didUpdateProviderLog?.call(provider, previousValue, newValue, container);
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object? error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    providerDidFailLog?.call(provider, error, stackTrace, container);
  }
}
