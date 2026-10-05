// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TenantInfoModel _$TenantInfoModelFromJson(Map<String, dynamic> json) =>
    _TenantInfoModel(
      tenantId: json['tenant_id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      propertyName: json['property_name'] as String,
      unitNumber: json['unit_number'] as String,
    );

Map<String, dynamic> _$TenantInfoModelToJson(_TenantInfoModel instance) =>
    <String, dynamic>{
      'tenant_id': instance.tenantId,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'property_name': instance.propertyName,
      'unit_number': instance.unitNumber,
    };
