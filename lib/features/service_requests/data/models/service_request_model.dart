import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenant_app/core/utils/functions.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

part 'service_request_model.freezed.dart';
part 'service_request_model.g.dart';

@freezed
abstract class ServiceRequestModel with _$ServiceRequestModel {
  const ServiceRequestModel._();

  const factory ServiceRequestModel({
    required String id,
    @JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)
    required ServiceType serviceType,
    required String description,
    @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)
    required DateTime preferredDate,
    @Default(false) bool isUrgent,
    @JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson)
    required RequestStatus status,
    @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) required DateTime createdAt,

    /// Attachment name as stored by the backend / on disk.
    String? imageFileName,

    /// Absolute on-device path, resolved by the repository at read time (iOS
    /// changes the app container path between installs/updates, so an absolute
    /// path must never be persisted). Not part of the JSON.
    @JsonKey(includeFromJson: false, includeToJson: false) String? localImagePath,
  }) = _ServiceRequestModel;

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) => _$ServiceRequestModelFromJson(json);

  /// Short, tenant-facing reference derived from the id, e.g. `REQ-3F9A1C2E`.
  String get referenceNumber {
    final String compact = id.replaceAll('-', '').toUpperCase();
    return 'REQ-${compact.length > 8 ? compact.substring(0, 8) : compact}';
  }
}
