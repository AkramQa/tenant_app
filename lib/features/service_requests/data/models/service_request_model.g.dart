// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceRequestModel _$ServiceRequestModelFromJson(
  Map<String, dynamic> json,
) => _ServiceRequestModel(
  id: json['id'] as String,
  serviceType: ServiceTypeConverter.fromJson(json['service_type'] as String?),
  description: json['description'] as String,
  preferredDate: convertStringToRequiredDate(json['preferred_date'] as String),
  isUrgent: json['is_urgent'] as bool? ?? false,
  status: RequestStatusConverter.fromJson(json['status'] as String?),
  createdAt: convertStringToRequiredDate(json['created_at'] as String),
  imageFileName: json['image_file_name'] as String?,
);

Map<String, dynamic> _$ServiceRequestModelToJson(
  _ServiceRequestModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'service_type': ServiceTypeConverter.toJson(instance.serviceType),
  'description': instance.description,
  'preferred_date': convertRequiredDateToString(instance.preferredDate),
  'is_urgent': instance.isUrgent,
  'status': RequestStatusConverter.toJson(instance.status),
  'created_at': convertRequiredDateToString(instance.createdAt),
  'image_file_name': instance.imageFileName,
};
