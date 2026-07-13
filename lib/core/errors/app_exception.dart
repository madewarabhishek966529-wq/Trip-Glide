/// Base class for all app-level exceptions. Repositories throw these
/// instead of raw Hive/platform exceptions so the UI layer can react to a
/// small, known set of failure types (see error_handling widgets).
sealed class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class StorageException extends AppException {
  const StorageException([super.message = 'Something went wrong while saving your data.']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'The item you were looking for could not be found.']);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class NoConnectivityException extends AppException {
  const NoConnectivityException([super.message = 'No internet connection.']);
}
