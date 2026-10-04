import 'package:dartz/dartz.dart' show Either;
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

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
