import 'package:dio/dio.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/network/mock/mock_server.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_type.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

/// `POST /auth/sign-in`: accepts the demo account by email or phone number.
class AuthMockServer implements MockServer {
  static final RegExp _nonDigits = RegExp(r'\D');

  static const TenantInfoModel _demoTenant = TenantInfoModel(
    tenantId: 'tenant-001',
    fullName: 'Akram Qassem',
    email: kDemoEmail,
    phoneNumber: kDemoPhoneNumber,
    propertyName: 'Marina Heights Residence',
    unitNumber: 'B-1204',
  );

  @override
  Future<MockResponse?> handle(RequestOptions options) async {
    if (options.method != 'POST' || options.uri.path != '/auth/sign-in') return null;

    final Map<String, dynamic> body = options.data as Map<String, dynamic>;
    final SignInType? signInType = _resolveSignInType(body['identifier'] as String? ?? '');
    if (signInType == null || body['password'] != kDemoPassword) {
      return const MockResponse(422);
    }
    return MockResponse(
      200,
      data: SignInResponseModel(
        accessToken: 'mock-token-${DateTime.now().microsecondsSinceEpoch}',
        tenant: _demoTenant,
        signInType: signInType,
      ).toJson(),
    );
  }

  /// How the demo user signed in, or `null` if the identifier isn't theirs.
  SignInType? _resolveSignInType(String identifier) {
    final String normalized = identifier.trim().toLowerCase();
    if (normalized == kDemoEmail) return SignInType.email;

    final String digits = normalized.replaceAll(_nonDigits, '');
    // Accept local (050…) and international (97150…) formats.
    final bool isDemoPhone = digits == kDemoPhoneNumber || digits == '971${kDemoPhoneNumber.substring(1)}';
    return isDemoPhone ? SignInType.phoneNumber : null;
  }
}
