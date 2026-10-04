part of 'service_requests_list_notifier.dart';

sealed class ServiceRequestsListState {}

class InitialServiceRequestsList extends ServiceRequestsListState {}

class ServiceRequestsListLoading extends ServiceRequestsListState {}

class ServiceRequestsListSuccessful extends ServiceRequestsListState {
  final List<ServiceRequestModel> serviceRequests;

  /// `true` while showing the offline cache (before / instead of fresh data).
  final bool isFromCache;

  /// Set when a refresh failed but cached data is still displayed.
  final Failure? refreshFailure;

  ServiceRequestsListSuccessful(
    this.serviceRequests, {
    this.isFromCache = false,
    this.refreshFailure,
  });
}

class ServiceRequestsListFailure extends ServiceRequestsListState {
  final Failure failure;

  ServiceRequestsListFailure(this.failure);
}
