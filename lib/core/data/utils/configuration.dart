import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/utils/app_environment.dart';

abstract class Configuration {
  String get environment;

  String get getBaseUrl;

  factory Configuration.fromEnvironment(String environment) => switch (environment) {
        AppEnvironment.dev => DevConfiguration(),
        AppEnvironment.staging => StagingConfiguration(),
        _ => ProductionConfiguration(),
      };
}

class DevConfiguration implements Configuration {
  @override
  String get environment => AppEnvironment.dev;

  // TODO(SETUP): real dev API host.
  @override
  String get getBaseUrl => 'https://dev-api.example.com/';
}

class StagingConfiguration implements Configuration {
  @override
  String get environment => AppEnvironment.staging;

  // TODO(SETUP): real staging API host.
  @override
  String get getBaseUrl => 'https://stg-api.example.com/';
}

class ProductionConfiguration implements Configuration {
  @override
  String get environment => AppEnvironment.prod;

  // TODO(SETUP): real production API host.
  @override
  String get getBaseUrl => 'https://api.example.com/';
}

/// Overridden in `main()` with the flavor's configuration.
final configurationProvider = Provider<Configuration>(
  (ref) => throw UnimplementedError('configurationProvider is created in initAppDependencies()'),
);
