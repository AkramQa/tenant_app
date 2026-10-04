enum ServiceType {
  maintenance('maintenance'),
  plumbing('plumbing'),
  electrical('electrical'),
  acMaintenance('ac_maintenance'),
  cleaning('cleaning'),
  unknown('unknown');

  final String value;

  const ServiceType(this.value);

  /// Selectable service types (excludes [unknown]).
  static List<ServiceType> getValues() => ServiceType.values.where((type) => type != unknown).toList();
}

class ServiceTypeConverter {
  const ServiceTypeConverter();

  static ServiceType fromJson(String? serviceTypeAsString) => ServiceType.values.firstWhere(
        (type) => type.value == serviceTypeAsString,
        orElse: () => ServiceType.unknown,
      );

  static String toJson(ServiceType serviceType) => serviceType.value;
}
