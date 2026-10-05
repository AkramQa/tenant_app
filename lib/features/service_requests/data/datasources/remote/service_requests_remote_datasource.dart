import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tenant_app/core/data/models/base_response.dart';
import 'package:tenant_app/core/data/utils/configuration.dart';
import 'package:tenant_app/features/service_requests/data/models/create_service_request_body_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/injectable_module.dart';

part 'service_requests_remote_datasource.g.dart';

abstract class ServiceRequestsRemoteDataSource {
  Future<BaseResponse<List<ServiceRequestModel>>> fetchServiceRequests();

  Future<BaseResponse<ServiceRequestModel>> fetchServiceRequestDetails({required String requestId});

  Future<BaseResponse<ServiceRequestModel>> createServiceRequest({required CreateServiceRequestBodyModel body});
}

/// `@LazySingleton(as: ServiceRequestsRemoteDataSource)`
final serviceRequestsRemoteDataSourceProvider = Provider<ServiceRequestsRemoteDataSource>(
  (ref) => ServiceRequestsRemoteDataSourceImpl(ref.watch(dioProvider), ref.watch(configurationProvider)),
);

@RestApi(baseUrl: '')
abstract class ServiceRequestsRemoteDataSourceImpl implements ServiceRequestsRemoteDataSource {
  factory ServiceRequestsRemoteDataSourceImpl(Dio dio, Configuration configuration) {
    return _ServiceRequestsRemoteDataSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @override
  @GET('/service-requests')
  Future<BaseResponse<List<ServiceRequestModel>>> fetchServiceRequests();

  @override
  @GET('/service-requests/{id}')
  Future<BaseResponse<ServiceRequestModel>> fetchServiceRequestDetails({
    @Path('id') required String requestId,
  });

  @override
  @POST('/service-requests')
  Future<BaseResponse<ServiceRequestModel>> createServiceRequest({
    @Body() required CreateServiceRequestBodyModel body,
  });
}
