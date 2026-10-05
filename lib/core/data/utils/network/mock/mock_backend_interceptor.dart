import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/network/mock/mock_server.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';

/// Answers every request locally until a real backend exists: adds latency,
/// fails like a dropped connection when offline, and routes the rest to the
/// feature [MockServer]s. Retrofit and Dio run unchanged; remove this
/// interceptor to talk to `Configuration.getBaseUrl` for real.
class MockBackendInterceptor extends Interceptor {
  MockBackendInterceptor(this.networkInfo, this.servers, {this.latency = kMockApiLatency});

  final NetworkInfo networkInfo;
  final List<MockServer> servers;
  final Duration latency;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final bool isConnected = await networkInfo.isConnected;
    await Future<void>.delayed(latency);
    if (!isConnected) {
      return handler.reject(DioException.connectionError(requestOptions: options, reason: 'Offline'));
    }

    // Round-trip through JSON like a real wire: bodies and nested models become plain maps.
    options.data = _overTheWire(options.data);
    MockResponse? response;
    for (final server in servers) {
      response = await server.handle(options);
      if (response != null) break;
    }
    response ??= const MockResponse(404, message: 'Route not found');

    final Response<Object?> dioResponse =
        Response(requestOptions: options, statusCode: response.statusCode, data: _overTheWire(response.toJson()));
    // Interceptors bypass `validateStatus`, so non-2xx must be rejected explicitly.
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return handler.resolve(dioResponse);
    }
    return handler.reject(
      DioException.badResponse(statusCode: response.statusCode, requestOptions: options, response: dioResponse),
    );
  }

  static Object? _overTheWire(Object? data) => data == null ? null : json.decode(json.encode(data));
}
