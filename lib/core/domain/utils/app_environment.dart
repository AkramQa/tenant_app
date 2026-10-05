import 'package:tenant_app/core/data/utils/flavor_settings.dart';

class AppEnvironment {
  /// name of the environment
  final String name;

  /// default constructor
  const AppEnvironment(this.name);

  /// preset of common env name 'dev'
  static const dev = 'dev';

  /// preset of common env name 'prod'
  static const prod = 'prod';

  /// preset of common env name 'staging'
  static const staging = 'staging';

  static Future<String> getAppEnvironment() async {
    final settings = await getFlavorSettings();
    return switch (settings.flavorType) {
      FlavorType.dev => AppEnvironment.dev,
      FlavorType.staging => AppEnvironment.staging,
      FlavorType.prod => AppEnvironment.prod,
    };
  }
}
