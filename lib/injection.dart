import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_app/core/data/utils/constants.dart';

/// Async dependencies that must exist before the first frame
/// (the `@preResolve` registrations of the GetIt setup).
class PreResolvedDependencies {
  const PreResolvedDependencies({
    required this.sharedPreferences,
    required this.hiveCacheBox,
    required this.documentsDirectory,
  });

  final SharedPreferences sharedPreferences;
  final Box<dynamic> hiveCacheBox;
  final Directory documentsDirectory;
}

/// Equivalent of `configureInjection()`. Everything else is wired lazily by
/// Riverpod providers declared next to the class they create.
Future<PreResolvedDependencies> configureInjection() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);

  final sharedPreferences = await SharedPreferences.getInstance();
  final hiveCacheBox = await Hive.openBox<dynamic>(HiveKeys.kCacheBox);

  return PreResolvedDependencies(
    sharedPreferences: sharedPreferences,
    hiveCacheBox: hiveCacheBox,
    documentsDirectory: documentsDirectory,
  );
}
