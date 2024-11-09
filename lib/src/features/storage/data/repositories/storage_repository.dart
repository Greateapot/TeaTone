import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:path/path.dart' as pathlib;
import 'package:teatone/src/features/storage/storage.dart';

class StorageRepository {
  static const String parametersFilename = '.params';

  final InternalStorageDataProvider _internalStorageDataProvider;
  final ExternalStorageDataProvider _externalStorageDataProvider;

  const StorageRepository({
    InternalStorageDataProvider internalStorageDataProvider =
        const InternalStorageDataProvider(),
    ExternalStorageDataProvider externalStorageDataProvider =
        const ExternalStorageDataProvider(),
  })  : _internalStorageDataProvider = internalStorageDataProvider,
        _externalStorageDataProvider = externalStorageDataProvider;

  Future<bool> deleteRecord(Record record) async {
    final result =
        await _getStorageDatasourceByType(record.type).delete(record.title);

    // only extmem may be unavailable
    if (result == null) throw const StorageIsUnavailableException();

    return result;
  }

  Future<String> getNewRecordName(StorageType type) async {
    final storageDirectory =
        await _getStorageDatasourceByType(type).getStorageDirectory();

    // only extmem may be unavailable
    if (storageDirectory == null) throw const StorageIsUnavailableException();

    return pathlib.join(
      storageDirectory.path,
      'teatone_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
  }

  Future<Parameters> getParameters() async {
    final parameters =
        await _internalStorageDataProvider.read(parametersFilename);

    if (parameters == null) return Parameters.defaults();

    try {
      final json = jsonDecode(parameters) as Map<String, dynamic>;
      return Parameters.fromJson(json);
    } on FormatException {
      return Parameters.defaults();
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in _StorageRepositoryImpl.getParameters',
        error: error,
        stackTrace: stackTrace,
      );

      return Parameters.defaults();
    }
  }

  Future<bool> setParameters(Parameters parameters) async {
    final String contents = jsonEncode(parameters.toJson());

    final result = await _internalStorageDataProvider.write(
      parametersFilename,
      contents,
    );

    return result!;
  }

  Future<List<Record>> getRecords(StorageType type) async {
    final entities = await _getStorageDatasourceByType(type).list();

    // only extmem may be unavailable
    if (entities == null) throw const StorageIsUnavailableException();

    final List<Record> records = [];

    for (var entity in entities) {
      if (entity.path.endsWith('.m4a')) {
        final stat = await entity.stat();
        if (stat.type != FileSystemEntityType.file) continue;
        final title = pathlib.split(entity.path).last;
        records.add(Record(
          title: title,
          path: entity.path,
          createdAt: stat.changed,
          type: type,
        ));
      }
    }

    return records;
  }

  Future<int> getRecordsCount(StorageType type) async {
    final entities = await _getStorageDatasourceByType(type).list();

    // only extmem may be unavailable
    if (entities == null) throw const StorageIsUnavailableException();

    int count = 0;

    for (var entity in entities) {
      if (entity.path.endsWith('.m4a')) {
        final stat = await entity.stat();
        if (stat.type != FileSystemEntityType.file) continue;
        count++;
      }
    }

    return count;
  }

  Future<bool> isExternalStorageAvailable() async =>
      (await _externalStorageDataProvider.getStorageDirectory()) != null;

  AbstractStorageDataProvider _getStorageDatasourceByType(StorageType type) {
    if (type == StorageType.internal) {
      return _internalStorageDataProvider;
    } else {
      return _externalStorageDataProvider;
    }
  }
}
