import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';
import 'package:tenant_app/injectable_module.dart';

/// Developer toggle (Profile → Developer options) that forces every mock
/// API call to fail with `noInternetConnection`, to demo offline handling.
final simulateOfflineProvider = NotifierProvider<SimulateOfflineNotifier, bool>(SimulateOfflineNotifier.new);

class SimulateOfflineNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setSimulateOffline(bool value) => state = value;
}

/// `@LazySingleton(as: NetworkInfo)`
final networkInfoProvider = Provider<NetworkInfo>(
  (ref) => NetworkInfoImpl(
    ref.watch(connectionCheckerProvider),
    isOfflineSimulated: () => ref.read(simulateOfflineProvider),
  ),
);

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connectionChecker;
  final bool Function() isOfflineSimulated;

  NetworkInfoImpl(this.connectionChecker, {required this.isOfflineSimulated});

  @override
  Future<bool> get isConnected async {
    if (isOfflineSimulated()) return false;
    return connectionChecker.hasInternetAccess;
  }
}
