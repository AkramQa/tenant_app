import 'package:dartz/dartz.dart' show Either, Unit, right, unit;
import 'package:logger/logger.dart';
import 'package:tenant_app/core/data/repositories/base_repository_impl.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/features/service_requests/data/datasources/local/service_requests_local_source.dart';
import 'package:tenant_app/features/service_requests/data/datasources/remote/service_requests_remote_datasource.dart';
import 'package:tenant_app/features/service_requests/data/models/create_service_request_body_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/core/di/app_providers.dart';

final serviceRequestsRepositoryOverride = serviceRequestsRepositoryProvider.overrideWith(
  (ref) => ServiceRequestsRepositoryImpl(
    ref.watch(serviceRequestsRemoteDataSourceProvider),
    ref.watch(serviceRequestsLocalDataSourceProvider),
    ref.watch(loggerProvider),
  ),
);

class ServiceRequestsRepositoryImpl extends BaseRepositoryImpl implements ServiceRequestsRepository {
  final ServiceRequestsRemoteDataSource remote;
  final ServiceRequestsLocalDataSource local;

  ServiceRequestsRepositoryImpl(this.remote, this.local, Logger logger) : super(logger);

  @override
  Future<Either<Failure, List<ServiceRequestModel>>> fetchServiceRequests() {
    return request(() async {
      final response = await remote.fetchServiceRequests();
      return right(_sortedNewestFirst(response.requireData.map(_withLocalImagePath).toList()));
    });
  }

  @override
  Future<Either<Failure, ServiceRequestModel>> fetchServiceRequestDetails({required String requestId}) {
    return request(() async {
      final response = await remote.fetchServiceRequestDetails(requestId: requestId);
      return right(_withLocalImagePath(response.requireData));
    });
  }

  @override
  Future<Either<Failure, ServiceRequestModel>> createServiceRequest({
    required ServiceType serviceType,
    required String description,
    required DateTime preferredDate,
    required bool isUrgent,
    String? imagePath,
  }) {
    return request(() async {
      // Real backend: this would be a multipart upload returning a URL/id.
      final String? imageFileName = imagePath == null ? null : await local.saveAttachment(sourcePath: imagePath);
      try {
        final response = await remote.createServiceRequest(
          body: CreateServiceRequestBodyModel(
            serviceType: serviceType,
            description: description,
            preferredDate: preferredDate,
            isUrgent: isUrgent,
            imageFileName: imageFileName,
          ),
        );
        return right(_withLocalImagePath(response.requireData));
      } catch (_) {
        // Nothing references the copy if the request was not created.
        if (imageFileName != null) await local.deleteAttachment(fileName: imageFileName);
        rethrow;
      }
    });
  }

  @override
  Future<Either<Failure, bool>> cacheServiceRequests({required List<ServiceRequestModel> serviceRequests}) {
    return localRequest(() async {
      return right(await local.cacheServiceRequests(serviceRequests: serviceRequests));
    });
  }

  @override
  Future<Either<Failure, List<ServiceRequestModel>?>> fetchCachedServiceRequests() {
    return localRequest(() async {
      final cached = await local.fetchCachedServiceRequests();
      return right(cached == null ? null : _sortedNewestFirst(cached.map(_withLocalImagePath).toList()));
    });
  }

  @override
  Future<Either<Failure, Unit>> clearCachedServiceRequests() {
    return localRequest(() async {
      await local.clearCachedServiceRequests();
      return right(unit);
    });
  }

  ServiceRequestModel _withLocalImagePath(ServiceRequestModel request) =>
      request.copyWith(localImagePath: local.resolveAttachmentPath(request.imageFileName));

  List<ServiceRequestModel> _sortedNewestFirst(List<ServiceRequestModel> requests) =>
      requests..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
