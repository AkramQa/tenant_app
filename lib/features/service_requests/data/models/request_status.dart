enum RequestStatus {
  pending('pending'),
  assigned('assigned'),
  inProgress('in_progress'),
  completed('completed'),
  unknown('unknown');

  final String value;

  const RequestStatus(this.value);

  /// The lifecycle in order (excludes [unknown]) — drives the progress timeline.
  static List<RequestStatus> getValues() => RequestStatus.values.where((status) => status != unknown).toList();

  /// Zero-based position in the lifecycle, or `-1` for [unknown].
  int get step => getValues().indexOf(this);
}

class RequestStatusConverter {
  const RequestStatusConverter();

  static RequestStatus fromJson(String? statusAsString) => RequestStatus.values.firstWhere(
        (status) => status.value == statusAsString,
        orElse: () => RequestStatus.unknown,
      );

  static String toJson(RequestStatus status) => status.value;
}
