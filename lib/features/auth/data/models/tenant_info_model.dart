import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_info_model.freezed.dart';

part 'tenant_info_model.g.dart';

@freezed
class TenantInfoModel with _$TenantInfoModel {
  const TenantInfoModel._();

  const factory TenantInfoModel({
    required String tenantId,
    required String fullName,
    String? email,
    String? phoneNumber,
    required String propertyName,
    required String unitNumber,
  }) = _TenantInfoModel;

  factory TenantInfoModel.fromJson(Map<String, dynamic> json) => _$TenantInfoModelFromJson(json);

  /// "SA" for "Sara Al Mansoori" — used by avatars.
  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    final first = parts.first.substring(0, 1);
    final last = parts.length > 1 ? parts.last.substring(0, 1) : '';
    return '$first$last'.toUpperCase();
  }
}
