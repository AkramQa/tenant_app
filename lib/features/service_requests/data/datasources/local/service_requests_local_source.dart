import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/data/utils/exception.dart';
import 'package:tenant_app/features/service_requests/data/models/service_request_model.dart';
import 'package:tenant_app/injectable_module.dart';
import 'package:uuid/uuid.dart';

abstract class ServiceRequestsLocalDataSource {
  Future<bool> cacheServiceRequests({required List<ServiceRequestModel> serviceRequests});

  Future<List<ServiceRequestModel>?> fetchCachedServiceRequests();

  /// Copies a picked image into the app documents folder (picker files live
  /// in a temp dir the OS may purge) and returns the stored file name.
  Future<String> saveAttachment({required String sourcePath});

  /// Removes a stored attachment; a missing file is not an error.
  Future<void> deleteAttachment({required String fileName});

  /// Absolute path for a stored attachment name.
  String? resolveAttachmentPath(String? fileName);

  /// Drops the cached request list (on logout).
  Future<void> clearCachedServiceRequests();
}

/// `@LazySingleton(as: ServiceRequestsLocalDataSource)`
final serviceRequestsLocalDataSourceProvider = Provider<ServiceRequestsLocalDataSource>(
  (ref) => ServiceRequestsLocalDataSourceImpl(
    ref.watch(hiveCacheBoxProvider),
    ref.watch(appDocumentsDirectoryProvider),
    ref.watch(uuidProvider),
  ),
);

class ServiceRequestsLocalDataSourceImpl implements ServiceRequestsLocalDataSource {
  final Box<dynamic> cacheBox;
  final Directory documentsDirectory;
  final Uuid uuid;

  ServiceRequestsLocalDataSourceImpl(this.cacheBox, this.documentsDirectory, this.uuid);

  @override
  Future<bool> cacheServiceRequests({required List<ServiceRequestModel> serviceRequests}) async {
    await cacheBox.put(
      HiveKeys.kServiceRequests,
      serviceRequests.map((request) => json.encode(request.toJson())).toList(),
    );
    return true;
  }

  @override
  Future<List<ServiceRequestModel>?> fetchCachedServiceRequests() async {
    final List<dynamic>? cached = cacheBox.get(HiveKeys.kServiceRequests) as List<dynamic>?;
    return cached
        ?.map((request) => ServiceRequestModel.fromJson(json.decode(request as String) as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<String> saveAttachment({required String sourcePath}) async {
    try {
      final Directory attachmentsDirectory = Directory(p.join(documentsDirectory.path, kAttachmentsFolder));
      if (!attachmentsDirectory.existsSync()) {
        await attachmentsDirectory.create(recursive: true);
      }
      final String fileName = '${uuid.v4()}${p.extension(sourcePath)}';
      await File(sourcePath).copy(p.join(attachmentsDirectory.path, fileName));
      return fileName;
    } on FileSystemException catch (e) {
      throw CacheException('Could not store attachment: ${e.message}');
    }
  }

  @override
  Future<void> deleteAttachment({required String fileName}) async {
    final File file = File(p.join(documentsDirectory.path, kAttachmentsFolder, fileName));
    if (file.existsSync()) await file.delete();
  }

  @override
  Future<void> clearCachedServiceRequests() => cacheBox.delete(HiveKeys.kServiceRequests);

  @override
  String? resolveAttachmentPath(String? fileName) =>
      fileName == null ? null : p.join(documentsDirectory.path, kAttachmentsFolder, fileName);
}
