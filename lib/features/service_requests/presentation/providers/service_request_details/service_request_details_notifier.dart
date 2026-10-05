import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';

import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';

part 'service_request_details_state.dart';

/// One notifier per request id, disposed when
/// the details screen closes.
final serviceRequestDetailsProvider = NotifierProvider.autoDispose
    .family<ServiceRequestDetailsNotifier, ServiceRequestDetailsState, String>(ServiceRequestDetailsNotifier.new);

class ServiceRequestDetailsNotifier extends Notifier<ServiceRequestDetailsState> {
  ServiceRequestDetailsNotifier(this.requestId);

  final String requestId;

  ServiceRequestsRepository get _repository => ref.read(serviceRequestsRepositoryProvider);

  @override
  ServiceRequestDetailsState build() => InitialServiceRequestDetails();

  Future<void> fetchServiceRequestDetails() async {
    state = ServiceRequestDetailsLoading();

    final result = await _repository.fetchServiceRequestDetails(requestId: requestId);
    if (!ref.mounted) return;

    await result.fold<Future<void>>(
      (failure) async {
        // Offline: fall back to the cached copy of this request.
        if (failure is ServerFailure && failure.errorCode == ServerErrorCode.noInternetConnection) {
          final cachedResult = await _repository.fetchCachedServiceRequests();
          if (!ref.mounted) return;
          final ServiceRequestModel? cached = cachedResult.fold(
            (_) => null,
            (requests) => requests?.where((request) => request.id == requestId).firstOrNull,
          );
          if (cached != null) {
            state = ServiceRequestDetailsSuccessful(serviceRequest: cached, isFromCache: true);
            return;
          }
        }
        state = ServiceRequestDetailsFailure(failure);
      },
      (serviceRequest) async => state = ServiceRequestDetailsSuccessful(serviceRequest: serviceRequest),
    );
  }
}
