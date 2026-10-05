import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';

/// Status filter of the Requests tab; `null` means "All". App-wide so the
/// create flow can reset it and the new (Pending) request is never hidden.
final serviceRequestsFilterProvider = NotifierProvider<ServiceRequestsFilterNotifier, RequestStatus?>(
  ServiceRequestsFilterNotifier.new,
);

class ServiceRequestsFilterNotifier extends Notifier<RequestStatus?> {
  @override
  RequestStatus? build() => null;

  void select(RequestStatus? status) => state = status;

  void clear() => state = null;
}
