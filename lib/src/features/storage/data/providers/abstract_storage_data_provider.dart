import 'dart:io';

import 'package:teatone/src/features/storage/storage.dart';

abstract interface class AbstractStorageDataProvider {
  StorageType get type;

  Future<List<FileSystemEntity>?> list();
  Future<String?> read(String filename);
  Future<bool?> write(String filename, String contents);
  Future<bool?> delete(String filename);

  Future<Directory?> getStorageDirectory();

  /// Почти CRUD (расширенный), только 'U' нет, т.к. 'C' (write) его покрывает.
}
