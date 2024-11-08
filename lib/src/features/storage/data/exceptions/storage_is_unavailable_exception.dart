class StorageIsUnavailableException implements Exception {
  final String? message;

  const StorageIsUnavailableException([this.message]);

  @override
  String toString() {
    if (message == null) {
      return 'StorageIsUnavailableException';
    } else {
      return 'StorageIsUnavailableException: $message';
    }
  }
}
