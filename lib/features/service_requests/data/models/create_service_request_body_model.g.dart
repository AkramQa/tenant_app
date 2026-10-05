// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_service_request_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateServiceRequestBodyModel _$CreateServiceRequestBodyModelFromJson(
  Map<String, dynamic> json,
) => _CreateServiceRequestBodyModel(
  serviceType: ServiceTypeConverter.fromJson(json['service_type'] as String?),
  description: json['description'] as String,
  preferredDate: convertStringToRequiredDate(json['preferred_date'] as String),
  isUrgent: json['is_urgent'] as bool? ?? false,
  imageFileName: json['image_file_name'] as String?,
);

Map<String, dynamic> _$CreateServiceRequestBodyModelToJson(
  _CreateServiceRequestBodyModel instance,
) => <String, dynamic>{
  'service_type': ServiceTypeConverter.toJson(instance.serviceType),
  'description': instance.description,
  'preferred_date': convertRequiredDateToString(instance.preferredDate),
  'is_urgent': instance.isUrgent,
  'image_file_name': instance.imageFileName,
};
