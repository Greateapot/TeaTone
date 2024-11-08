import 'dart:developer' as dev;
import 'dart:io';

import 'package:path/path.dart' as pathlib;
import 'package:path_provider/path_provider.dart';
import 'package:teatone/storage/storage.dart';

final class InternalStorageDataProvider implements AbstractStorageDataProvider {
  static const String storageDirname = 'intmem';
  static const int storageMaxSize = 64 * 1024; // 64 kB

  /// Внутренний накопитель. Если нет - создать и вернуть значение.
  const InternalStorageDataProvider();

  @override
  StorageType get type => StorageType.internal;

  @override
  Future<bool?> delete(String filename) async {
    if (filename.contains('/') || filename.contains('\\')) {
      throw const InvalidFilenameException();
    }

    final storageDirectory = await getStorageDirectory();

    final file = File(pathlib.join(storageDirectory!.path, filename));

    // Заранее исключаем ошибку несуществующего файла
    if (!await file.exists()) return false;

    try {
      await file.delete();
      return true;
    } on FileSystemException {
      return false;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in InternalStorageDatasource.delete',
        error: error,
        stackTrace: stackTrace,
      );

      return false;
    }
  }

  @override
  Future<List<FileSystemEntity>?> list() async {
    final storageDirectory = await getStorageDirectory();
    final entities = await storageDirectory!.list(followLinks: false).toList();
    return entities;
  }

  @override
  Future<String?> read(String filename) async {
    if (filename.contains('/') || filename.contains('\\')) {
      throw const InvalidFilenameException();
    }

    final storageDirectory = await getStorageDirectory();

    final file = File(pathlib.join(storageDirectory!.path, filename));

    // Заранее исключаем ошибку несуществующего файла
    if (!await file.exists()) return null;

    try {
      final content = await file.readAsString();
      return content;
    } on FileSystemException {
      return null;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in InternalStorageDatasource.read',
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

    final file = File(pathlib.join(storageDirectory!.path, filename));

    try {
      await file.writeAsString(contents);
      return true;
    } on FileSystemException {
      return false;
    } catch (error, stackTrace) {
      dev.log(
        'Encountered an error in InternalStorageDatasource.write',
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

    if (!await storageDirectory.exists()) {
      await storageDirectory.create(recursive: true);
    }

    return storageDirectory;
  }
}
