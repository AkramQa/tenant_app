import 'package:dio/dio.dart';

/// A fake HTTP response produced by a [MockServer].
class MockResponse {
  const MockResponse(this.statusCode, {this.data, this.message});

  final int statusCode;
  final Object? data;
  final String? message;

  /// Same envelope as a real response, so `BaseResponse.fromJson` parses it.
  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'data': data,
      };
}

/// Serves the routes of one feature without a network. Returns `null` when
/// the request is not one of its routes.
abstract class MockServer {
  Future<MockResponse?> handle(RequestOptions options);
}
