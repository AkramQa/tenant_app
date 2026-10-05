import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

/// Bound to its data-layer implementation in `main()` (see `repositoryOverrides`).
final serviceRequestsRepositoryProvider = Provider<ServiceRequestsRepository>(
  (ref) => throw UnimplementedError('serviceRequestsRepositoryProvider is overridden in main()'),
);

abstract class ServiceRequestsRepository {
  /// Remote list, newest first.
  Future<Either<Failure, List<ServiceRequestModel>>> fetchServiceRequests();

  Future<Either<Failure, ServiceRequestModel>> fetchServiceRequestDetails({required String requestId});

  Future<Either<Failure, ServiceRequestModel>> createServiceRequest({
    required ServiceType serviceType,
    required String description,
    required DateTime preferredDate,
    required bool isUrgent,
    String? imagePath,
  });

  Future<Either<Failure, bool>> cacheServiceRequests({required List<ServiceRequestModel> serviceRequests});

  /// Last list successfully loaded from the server (offline support);
  /// `Right(null)` when nothing is cached yet.
  Future<Either<Failure, List<ServiceRequestModel>?>> fetchCachedServiceRequests();
}
