import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/service_requests_list/service_requests_list_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/ui-models/create_service_request_input.dart';

part 'create_service_request_state.dart';

final createServiceRequestProvider =
    NotifierProvider.autoDispose<CreateServiceRequestNotifier, CreateServiceRequestState>(
  CreateServiceRequestNotifier.new,
);

class CreateServiceRequestNotifier extends Notifier<CreateServiceRequestState> {
  @override
  CreateServiceRequestState build() => CreateServiceRequestInitial();

  /// [input] must come from a valid form (required fields are non-null).
  Future<void> createServiceRequest(CreateServiceRequestInput input) async {
    if (state is CreateServiceRequestLoading) return;
    state = CreateServiceRequestLoading();

    final result = await ref.read(serviceRequestsRepositoryProvider).createServiceRequest(
          serviceType: input.serviceType!,
          description: input.description.trim(),
          preferredDate: input.preferredDate!,
          isUrgent: input.isUrgent,
          imagePath: input.imagePath,
        );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = CreateServiceRequestFailure(failure),
      (serviceRequest) {
        ref.read(serviceRequestsListProvider.notifier).addCreatedServiceRequest(serviceRequest);
        state = CreateServiceRequestSuccessful(serviceRequest: serviceRequest);
      },
    );
  }
}
