import 'dart:developer' as dev;
import 'dart:io';

import 'package:path/path.dart' as pathlib;
import 'package:path_provider/path_provider.dart';
import 'package:teatone/src/features/storage/storage.dart';

final class ExternalStorageDataProvider implements AbstractStorageDataProvider {
  static const String storageDirname = 'extmem';
  static const int storageMaxSize = 2 * 1024 * 1024 * 1024; // 2 GB

  /// Special for external storage
  static const String storageSizeFilename = '.ss';

  /// Внешний накопитель. Если нет - вернуть `null`.
  const ExternalStorageDataProvider();

  @override
  StorageType get type => StorageType.external;

  @override
  Future<bool?> delete(String filename) async {
    if (filename.contains('/') || filename.contains('\\')) {
      throw const InvalidFilenameException();
    }

    final storageDirectory = await getStorageDirectory();

    // Внешний накопитель отсутствует
    if (storageDirectory == null) return null;

    final file = File(pathlib.join(storageDirectory.path, filename));

    // Заранее исключаем ошибку несуществующего файла
    if (!await file.exists()) return false;

    try {
      await file.delete();
      return true;
    } on FileSystemException {
      return false;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in ExternalStorageDatasource.delete',
        error: error,
        stackTrace: stackTrace,
      );

      return false;
    }
  }

  @override
  Future<List<FileSystemEntity>?> list() async {
    final storageDirectory = await getStorageDirectory();

    // Внешний накопитель отсутствует
    if (storageDirectory == null) return null;

    final entities = await storageDirectory.list(followLinks: false).toList();
    return entities;
  }

  @override
  Future<String?> read(String filename) async {
    if (filename.contains('/') || filename.contains('\\')) {
      throw const InvalidFilenameException();
    }

    final storageDirectory = await getStorageDirectory();

    // Внешний накопитель отсутствует
    if (storageDirectory == null) return null;

    final file = File(pathlib.join(storageDirectory.path, filename));

    // Заранее исключаем ошибку несуществующего файла
    if (!await file.exists()) return null;

    try {
      final content = await file.readAsString();
      return content;
    } on FileSystemException {
      return null;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in ExternalStorageDatasource.read',
        error: error,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  @override
  Future<bool?> write(String filename, String contents) async {
    if (filename.contains('/') || filename.contains('\\')) {
      throw const InvalidFilenameException();
    }

    final storageDirectory = await getStorageDirectory();

    // Внешний накопитель отсутствует
    if (storageDirectory == null) return null;

    final file = File(pathlib.join(storageDirectory.path, filename));

    try {
      await file.writeAsString(contents);
      return true;
    } on FileSystemException {
      return false;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in ExternalStorageDatasource.write',
        error: error,
        stackTrace: stackTrace,
      );

      return false;
    }
  }

  @override
  Future<Directory?> getStorageDirectory() async {
    final cwd = await getApplicationSupportDirectory();
    final storageDirectory = Directory(pathlib.join(cwd.path, storageDirname));

    if (!await storageDirectory.exists()) return null;

    final storageSizeFile = File(
      pathlib.join(storageDirectory.path, storageSizeFilename),
    );

    if (!await storageSizeFile.exists()) return null;

    late final String rawStorageSize;

    try {
      rawStorageSize = await storageSizeFile.readAsString();
    } on FileSystemException {
      return null;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in ExternalStorageDatasource.getStorageDirectory',
        error: error,
        stackTrace: stackTrace,
      );

      return null;
    }

    final storageSize = int.tryParse(rawStorageSize);

    if (storageSize == null ||
        storageSize < 0 ||
        storageSize > storageMaxSize) {
      return null;
    }

    return storageDirectory;
  }
}
