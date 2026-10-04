import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/core/data/utils/network/network_info.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';

/// Stands in for the Dio client. Remote data sources call [send] the way a
/// Retrofit client would perform an HTTP call: it adds latency, and throws
/// [ServerException] (like `DioException`) when the device is offline.
/// Swapping in a real backend only touches the `*RemoteDataSourceImpl`s.
class MockApiClient {
  final NetworkInfo networkInfo;
  final Duration latency;

  MockApiClient(this.networkInfo, {this.latency = kMockApiLatency});

  Future<T> send<T>(FutureOr<T> Function() handler) async {
    final bool isConnected = await networkInfo.isConnected;
    await Future<void>.delayed(latency);
    if (!isConnected) {
      throw const ServerException(errorCode: ServerErrorCode.noInternetConnection);
    }
    return await handler();
  }
}

/// `@lazySingleton`
final mockApiClientProvider = Provider<MockApiClient>(
  (ref) => MockApiClient(ref.watch(networkInfoProvider)),
);
