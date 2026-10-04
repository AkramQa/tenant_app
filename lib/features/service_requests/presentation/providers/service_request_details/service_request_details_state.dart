part of 'service_request_details_notifier.dart';

sealed class ServiceRequestDetailsState {}

class InitialServiceRequestDetails extends ServiceRequestDetailsState {}

class ServiceRequestDetailsLoading extends ServiceRequestDetailsState {}

class ServiceRequestDetailsSuccessful extends ServiceRequestDetailsState {
  final ServiceRequestModel serviceRequest;
  final bool isFromCache;

  ServiceRequestDetailsSuccessful({required this.serviceRequest, this.isFromCache = false});
}

class ServiceRequestDetailsFailure extends ServiceRequestDetailsState {
  final Failure failure;

  ServiceRequestDetailsFailure(this.failure);
}
