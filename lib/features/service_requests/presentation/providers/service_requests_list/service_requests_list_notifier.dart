import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';

import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';

part 'service_requests_list_state.dart';

/// App-wide list shared by Home ("recent requests") and the Requests tab —
/// the counterpart of a `lazy: false` BlocProvider in Ulearna's `app.dart`.
final serviceRequestsListProvider =
    NotifierProvider<ServiceRequestsListNotifier, ServiceRequestsListState>(ServiceRequestsListNotifier.new);

class ServiceRequestsListNotifier extends Notifier<ServiceRequestsListState> {
  ServiceRequestsRepository get _repository => ref.read(serviceRequestsRepositoryProvider);

  @override
  ServiceRequestsListState build() => InitialServiceRequestsList();

  /// Cache-then-network: shows the cached list instantly (if any), then
  /// replaces it with fresh data. If the network fails but cached data is on
  /// screen, the data stays and the failure is exposed as [refreshFailure].
  Future<void> fetchServiceRequests() async {
    if (state is ServiceRequestsListLoading) return;

    if (state is! ServiceRequestsListSuccessful) {
      final cachedResult = await _repository.fetchCachedServiceRequests();
      if (!ref.mounted) return;
      final List<ServiceRequestModel>? cached = cachedResult.fold((_) => null, (requests) => requests);
      state = cached != null && cached.isNotEmpty
          ? ServiceRequestsListSuccessful(cached, isFromCache: true)
          : ServiceRequestsListLoading();
    }

    final result = await _repository.fetchServiceRequests();
    if (!ref.mounted) return;

    result.fold(
      (failure) {
        final current = state;
        state = current is ServiceRequestsListSuccessful
            ? ServiceRequestsListSuccessful(current.serviceRequests, isFromCache: true, refreshFailure: failure)
            : ServiceRequestsListFailure(failure);
      },
      (serviceRequests) {
        state = ServiceRequestsListSuccessful(serviceRequests);
        unawaited(_repository.cacheServiceRequests(serviceRequests: serviceRequests));
      },
    );
  }

  /// Inserts a request created on this device at the top of the list.
  void addCreatedServiceRequest(ServiceRequestModel serviceRequest) {
    final current = state;
    final List<ServiceRequestModel> serviceRequests = [
      serviceRequest,
      if (current is ServiceRequestsListSuccessful)
        ...current.serviceRequests.where((request) => request.id != serviceRequest.id),
    ];
    state = ServiceRequestsListSuccessful(
      serviceRequests,
      isFromCache: current is ServiceRequestsListSuccessful && current.isFromCache,
    );
    unawaited(_repository.cacheServiceRequests(serviceRequests: serviceRequests));
  }
}
