import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/core/data/utils/network/mock_api_client.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/injectable_module.dart';
import 'package:uuid/uuid.dart';

abstract class ServiceRequestsRemoteDataSource {
  Future<List<ServiceRequestModel>> fetchServiceRequests();

  Future<ServiceRequestModel> fetchServiceRequestDetails({required String requestId});

  Future<ServiceRequestModel> createServiceRequest({
    required ServiceType serviceType,
    required String description,
    required DateTime preferredDate,
    required bool isUrgent,
    String? imageFileName,
  });
}

/// `@LazySingleton(as: ServiceRequestsRemoteDataSource)`
final serviceRequestsRemoteDataSourceProvider = Provider<ServiceRequestsRemoteDataSource>(
  (ref) => ServiceRequestsRemoteDataSourceImpl(
    ref.watch(mockApiClientProvider),
    ref.watch(sharedPreferencesProvider),
    ref.watch(uuidProvider),
  ),
);

/// Mock backend. Its "database" is persisted in shared preferences so created
/// requests survive restarts like they would on a real server. Swap for a
/// Retrofit `@RestApi` implementation when an API exists.
class ServiceRequestsRemoteDataSourceImpl implements ServiceRequestsRemoteDataSource {
  final MockApiClient client;
  final SharedPreferences sharedPreferences;
  final Uuid uuid;
  final DateTime Function() clock;

  ServiceRequestsRemoteDataSourceImpl(
    this.client,
    this.sharedPreferences,
    this.uuid, {
    this.clock = DateTime.now,
  });

  @override
  Future<List<ServiceRequestModel>> fetchServiceRequests() => client.send(_readDatabase);

  @override
  Future<ServiceRequestModel> fetchServiceRequestDetails({required String requestId}) {
    return client.send(() {
      final request = _readDatabase().where((request) => request.id == requestId).firstOrNull;
      if (request == null) {
        throw const ServerException(errorCode: ServerErrorCode.notFound);
      }
      return request;
    });
  }

  @override
  Future<ServiceRequestModel> createServiceRequest({
    required ServiceType serviceType,
    required String description,
    required DateTime preferredDate,
    required bool isUrgent,
    String? imageFileName,
  }) {
    return client.send(() async {
      final created = ServiceRequestModel(
        id: uuid.v4(),
        serviceType: serviceType,
        description: description,
        preferredDate: preferredDate,
        isUrgent: isUrgent,
        status: RequestStatus.pending,
        createdAt: clock(),
        imageFileName: imageFileName,
      );
      await _writeDatabase([created, ..._readDatabase()]);
      return created;
    });
  }

  List<ServiceRequestModel> _readDatabase() {
    final String? raw = sharedPreferences.getString(SharedPreferencesKeys.mockServerServiceRequests);
    if (raw == null) {
      final seed = _seedRequests();
      _writeDatabase(seed);
      return seed;
    }
    final List<dynamic> decoded = json.decode(raw) as List<dynamic>;
    return decoded.map((item) => ServiceRequestModel.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<bool> _writeDatabase(List<ServiceRequestModel> requests) => sharedPreferences.setString(
        SharedPreferencesKeys.mockServerServiceRequests,
        json.encode(requests.map((request) => request.toJson()).toList()),
      );

  /// A few realistic requests so the app isn't empty on first launch.
  List<ServiceRequestModel> _seedRequests() {
    final DateTime now = clock();
    return [
      ServiceRequestModel(
        id: '3f9a1c2e-7b4d-4e21-9a6f-1c2d3e4f5a01',
        serviceType: ServiceType.acMaintenance,
        description: 'The living room AC is blowing warm air and making a rattling noise.',
        preferredDate: now.add(const Duration(days: 1)),
        isUrgent: true,
        status: RequestStatus.pending,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      ServiceRequestModel(
        id: '8b2e4d61-0c3a-4f5e-b7d9-2a3b4c5d6e02',
        serviceType: ServiceType.plumbing,
        description: 'Water is leaking under the kitchen sink cabinet.',
        preferredDate: now.add(const Duration(days: 2)),
        isUrgent: false,
        status: RequestStatus.inProgress,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      ServiceRequestModel(
        id: 'c47d9e13-5f2b-4a8c-9e1d-3b4c5d6e7f03',
        serviceType: ServiceType.electrical,
        description: 'Two power sockets in the master bedroom stopped working.',
        preferredDate: now.add(const Duration(days: 3)),
        isUrgent: false,
        status: RequestStatus.assigned,
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      ServiceRequestModel(
        id: 'e15b7a39-2d6c-4b0e-8f3a-4c5d6e7f8a04',
        serviceType: ServiceType.cleaning,
        description: 'Deep cleaning of the balcony and windows before guests arrive.',
        preferredDate: now.subtract(const Duration(days: 6)),
        isUrgent: false,
        status: RequestStatus.completed,
        createdAt: now.subtract(const Duration(days: 9)),
      ),
    ];
  }
}
