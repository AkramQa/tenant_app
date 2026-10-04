part of 'create_service_request_notifier.dart';

sealed class CreateServiceRequestState {}

class CreateServiceRequestInitial extends CreateServiceRequestState {}

class CreateServiceRequestLoading extends CreateServiceRequestState {}

class CreateServiceRequestSuccessful extends CreateServiceRequestState {
  final ServiceRequestModel serviceRequest;

  CreateServiceRequestSuccessful({required this.serviceRequest});
}

class CreateServiceRequestFailure extends CreateServiceRequestState {
  final Failure failure;

  CreateServiceRequestFailure(this.failure);
}
