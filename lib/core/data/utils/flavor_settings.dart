import 'package:flutter/services.dart';

enum FlavorType { dev, staging, prod }

class FlavorSettings {
  final String name;
  final FlavorType flavorType;

  FlavorSettings.dev()
      : name = 'DEV',
        flavorType = FlavorType.dev;

  FlavorSettings.staging()
      : name = 'STAGING',
        flavorType = FlavorType.staging;

  FlavorSettings.prod()
      : name = 'PRODUCTION',
        flavorType = FlavorType.prod;
}

Future<FlavorSettings> getFlavorSettings() async {
  final flavor = getFlavorName();
  final flavorSettings = switch (flavor) {
    'dev' => FlavorSettings.dev(),
    'staging' || 'stg' => FlavorSettings.staging(),
    'prod' => FlavorSettings.prod(),
    _ => FlavorSettings.prod(),
  };
  return flavorSettings;
}

String? getFlavorName() => appFlavor;
