import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/core/data/utils/network/mock_api_client.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_response_model.dart';
import 'package:tenant_app/features/auth/data/models/sign_in_type.dart';
import 'package:tenant_app/features/auth/data/models/tenant_info_model.dart';

abstract class AuthRemoteDataSource {
  /// [identifier] is an email address or a phone number.
  Future<SignInResponseModel> signIn({
    required String identifier,
    required String password,
  });
}

/// `@LazySingleton(as: AuthRemoteDataSource)`
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(ref.watch(mockApiClientProvider)),
);

/// Mock implementation of the auth API. Accepts the demo account by email
/// or phone number. Replace with a Retrofit `@RestApi` client when a backend
/// is available — the interface and everything above it stay unchanged.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final MockApiClient client;

  AuthRemoteDataSourceImpl(this.client);

  static final RegExp _nonDigits = RegExp(r'\D');

  static const TenantInfoModel _demoTenant = TenantInfoModel(
    tenantId: 'tenant-001',
    fullName: 'Sara Al Mansoori',
    email: kDemoEmail,
    phoneNumber: kDemoPhoneNumber,
    propertyName: 'Marina Heights Residence',
    unitNumber: 'B-1204',
  );

  @override
  Future<SignInResponseModel> signIn({
    required String identifier,
    required String password,
  }) {
    return client.send(() {
      final SignInType? signInType = _resolveSignInType(identifier);
      if (signInType == null || password != kDemoPassword) {
        throw const ServerException(errorCode: ServerErrorCode.wrongInput);
      }
      return SignInResponseModel(
        accessToken: 'mock-token-${DateTime.now().microsecondsSinceEpoch}',
        tenant: _demoTenant,
        signInType: signInType,
      );
    });
  }

  /// Returns how the demo user signed in, or `null` if the identifier does
  /// not belong to the demo account.
  SignInType? _resolveSignInType(String identifier) {
    final String normalized = identifier.trim().toLowerCase();
    if (normalized == kDemoEmail) return SignInType.email;

    final String digits = normalized.replaceAll(_nonDigits, '');
    // Accept local (050…) and international (97150…) formats.
    final bool isDemoPhone = digits == kDemoPhoneNumber || digits == '971${kDemoPhoneNumber.substring(1)}';
    return isDemoPhone ? SignInType.phoneNumber : null;
  }
}
