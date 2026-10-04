const String defaultJsonDateFormat = 'yyyy-MM-dd';

/// Mock backend round trip, so loading states are visible.
const Duration kMockApiLatency = Duration(milliseconds: 800);

const int kMinPasswordLength = 6;
const int kMinDescriptionLength = 10;
const int kMaxDescriptionLength = 500;
const int kRecentServiceRequestsLimit = 3;
const int kPreferredDateMaxDaysAhead = 90;
const String kAttachmentsFolder = 'attachments';

/// Demo account accepted by the mock authentication API.
const String kDemoEmail = 'tenant@demo.com';
const String kDemoPhoneNumber = '0501234567';
const String kDemoPassword = 'Tenant@123';

class SharedPreferencesKeys {
  static const String user = 'user';
  static const String lang = 'lang';
  static const String themeMode = 'theme_mode';

  /// Storage of the in-app mock backend (acts as the server database).
  static const String mockServerServiceRequests = 'mock_server_service_requests';
}

class SecureStorageKeys {
  static const String accessToken = 'access_token';
}

class HiveKeys {
  static const String kCacheBox = 'TenantAppCache';
  static const String kServiceRequests = 'ServiceRequests';
}
