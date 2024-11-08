class InvalidFilenameException implements Exception {
  final String? message;

  const InvalidFilenameException([this.message]);

  @override
  String toString() {
    if (message == null) {
      return 'InvalidFilenameException';
    } else {
      return 'InvalidFilenameException: $message';
    }
  }
}
