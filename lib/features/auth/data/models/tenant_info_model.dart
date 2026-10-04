import 'package:equatable/equatable.dart';

class TenantInfoModel extends Equatable {
  final String tenantId;
  final String fullName;
  final String? email;
  final String? phoneNumber;
  final String propertyName;
  final String unitNumber;

  const TenantInfoModel({
    required this.tenantId,
    required this.fullName,
    this.email,
    this.phoneNumber,
    required this.propertyName,
    required this.unitNumber,
  });

  factory TenantInfoModel.fromJson(Map<String, dynamic> json) => TenantInfoModel(
        tenantId: json['tenant_id'] as String,
        fullName: json['full_name'] as String,
        email: json['email'] as String?,
        phoneNumber: json['phone_number'] as String?,
        propertyName: json['property_name'] as String,
        unitNumber: json['unit_number'] as String,
      );

  Map<String, dynamic> toJson() => {
        'tenant_id': tenantId,
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'property_name': propertyName,
        'unit_number': unitNumber,
      };

  /// "SA" for "Sara Al Mansoori" — used by avatars.
  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    final first = parts.first.substring(0, 1);
    final last = parts.length > 1 ? parts.last.substring(0, 1) : '';
    return '$first$last'.toUpperCase();
  }

  @override
  List<Object?> get props => [tenantId, fullName, email, phoneNumber, propertyName, unitNumber];
}
