import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_type.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

TenantInfoModel fakeTenantInfoModel({String fullName = 'Akram Qassem'}) => TenantInfoModel(
      tenantId: 'tenant-001',
      fullName: fullName,
      email: 'tenant@demo.com',
      phoneNumber: '0501234567',
      propertyName: 'Marina Heights Residence',
      unitNumber: 'B-1204',
    );

SignInResponseModel fakeSignInResponseModel() => SignInResponseModel(
      accessToken: 'token',
      tenant: fakeTenantInfoModel(),
      signInType: SignInType.email,
    );

ServiceRequestModel fakeServiceRequestModel({
  String id = 'request-001',
  ServiceType serviceType = ServiceType.plumbing,
  RequestStatus status = RequestStatus.pending,
  bool isUrgent = false,
  DateTime? createdAt,
  String? imageFileName,
}) =>
    ServiceRequestModel(
      id: id,
      serviceType: serviceType,
      description: 'Water is leaking under the kitchen sink.',
      preferredDate: DateTime(2026, 10, 10),
      isUrgent: isUrgent,
      status: status,
      createdAt: createdAt ?? DateTime(2026, 10, 1),
      imageFileName: imageFileName,
    );
