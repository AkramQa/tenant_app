import 'package:dartz/dartz.dart' show Either, right;
import 'package:logger/logger.dart';
import 'package:tenant_app/core/data/repositories/base_repository_impl.dart';
import 'package:tenant_app/core/data/utils/network/network_info.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/network/network_info.dart';
import 'package:tenant_app/features/service_requests/data/datasources/local/service_requests_local_source.dart';
import 'package:tenant_app/features/service_requests/data/datasources/remote/service_requests_remote_datasource.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/domain/repositories/service_requests_repository.dart';
import 'package:tenant_app/injectable_module.dart';

/// `@LazySingleton(as: ServiceRequestsRepository)`
final serviceRequestsRepositoryOverride = serviceRequestsRepositoryProvider.overrideWith(
  (ref) => ServiceRequestsRepositoryImpl(
    ref.watch(serviceRequestsRemoteDataSourceProvider),
    ref.watch(serviceRequestsLocalDataSourceProvider),
    ref.watch(networkInfoProvider),
    ref.watch(loggerProvider),
  ),
);

class ServiceRequestsRepositoryImpl extends BaseRepositoryImpl implements ServiceRequestsRepository {
  final ServiceRequestsRemoteDataSource remote;
  final ServiceRequestsLocalDataSource local;

  ServiceRequestsRepositoryImpl(this.remote, this.local, NetworkInfo networkInfo, Logger logger)
      : super(networkInfo, logger);

  @override
  Future<Either<Failure, List<ServiceRequestModel>>> fetchServiceRequests() {
    return request(() async {
      final response = await remote.fetchServiceRequests();
      return right(_sortedNewestFirst(response.map(_withLocalImagePath).toList()));
    });
  }

  @override
  Future<Either<Failure, ServiceRequestModel>> fetchServiceRequestDetails({required String requestId}) {
    return request(() async {
      final response = await remote.fetchServiceRequestDetails(requestId: requestId);
      return right(_withLocalImagePath(response));
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
      final response = await remote.createServiceRequest(
        serviceType: serviceType,
        description: description,
        preferredDate: preferredDate,
        isUrgent: isUrgent,
        imageFileName: imageFileName,
      );
      return right(_withLocalImagePath(response));
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

  ServiceRequestModel _withLocalImagePath(ServiceRequestModel request) =>
      request.copyWith(localImagePath: () => local.resolveAttachmentPath(request.imageFileName));

  List<ServiceRequestModel> _sortedNewestFirst(List<ServiceRequestModel> requests) =>
      requests..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
