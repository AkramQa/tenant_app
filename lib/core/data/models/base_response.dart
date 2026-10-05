import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// API envelope: `{ "message", "error", "data", "statusCode" }` (same as Ulearna).
@JsonSerializable(genericArgumentFactories: true, createToJson: false, fieldRename: FieldRename.none)
class BaseResponse<T> {
  @JsonKey(name: 'message', defaultValue: '', fromJson: getErrorMessage)
  final String? message;
  final String? error;
  final T? data;
  final int? statusCode;

  BaseResponse({
    this.statusCode,
    this.message,
    this.error,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  static String? getErrorMessage(dynamic errorMessage) {
    if (errorMessage != null) {
      if (errorMessage is String && errorMessage.isNotEmpty) {
        return errorMessage;
      } else if (errorMessage is List && errorMessage.isNotEmpty) {
        final firstElement = errorMessage.first;
        if (firstElement is Map && firstElement.containsKey('field') && firstElement.containsKey('error')) {
          return '${firstElement['field']}: ${firstElement['error']}';
        }
      }
    }
    return null;
  }
}
