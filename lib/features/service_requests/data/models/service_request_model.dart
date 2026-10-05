import 'package:equatable/equatable.dart';
import 'package:tenant_app/core/utils/functions.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

class ServiceRequestModel extends Equatable {
  final String id;
  final ServiceType serviceType;
  final String description;
  final DateTime preferredDate;
  final bool isUrgent;
  final RequestStatus status;
  final DateTime createdAt;

  /// Attachment name as stored by the backend / on disk.
  final String? imageFileName;

  /// Absolute on-device path, resolved by the repository at read time (iOS
  /// changes the app container path between installs/updates, so an absolute
  /// path must never be persisted). Not part of the JSON.
  final String? localImagePath;

  const ServiceRequestModel({
    required this.id,
    required this.serviceType,
    required this.description,
    required this.preferredDate,
    required this.isUrgent,
    required this.status,
    required this.createdAt,
    this.imageFileName,
    this.localImagePath,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) => ServiceRequestModel(
        id: json['id'] as String,
        serviceType: ServiceTypeConverter.fromJson(json['service_type'] as String?),
        description: json['description'] as String,
        preferredDate: convertStringToRequiredDate(json['preferred_date'] as String),
        isUrgent: json['is_urgent'] as bool? ?? false,
        status: RequestStatusConverter.fromJson(json['status'] as String?),
        createdAt: convertStringToRequiredDate(json['created_at'] as String),
        imageFileName: json['image_file_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'service_type': ServiceTypeConverter.toJson(serviceType),
        'description': description,
        'preferred_date': convertRequiredDateToString(preferredDate),
        'is_urgent': isUrgent,
        'status': RequestStatusConverter.toJson(status),
        'created_at': convertRequiredDateToString(createdAt),
        'image_file_name': imageFileName,
      };

  /// Short, tenant-facing reference derived from the id, e.g. `REQ-3F9A1C2E`.
  String get referenceNumber {
    final String compact = id.replaceAll('-', '').toUpperCase();
    return 'REQ-${compact.length > 8 ? compact.substring(0, 8) : compact}';
  }

  ServiceRequestModel copyWith({
    RequestStatus? status,
    String? Function()? localImagePath,
  }) =>
      ServiceRequestModel(
        id: id,
        serviceType: serviceType,
        description: description,
        preferredDate: preferredDate,
        isUrgent: isUrgent,
        status: status ?? this.status,
        createdAt: createdAt,
        imageFileName: imageFileName,
        localImagePath: localImagePath != null ? localImagePath() : this.localImagePath,
      );

  @override
  List<Object?> get props =>
      [id, serviceType, description, preferredDate, isUrgent, status, createdAt, imageFileName, localImagePath];
}
