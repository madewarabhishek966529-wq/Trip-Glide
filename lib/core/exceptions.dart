/// Base type for every exception the app throws intentionally.
/// Catching `AppException` in the UI layer lets widgets show a friendly
/// message via `.message` without caring which concrete subtype it was.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Something went wrong reading/writing Hive (corrupt box, disk I/O, etc).
class StorageException extends AppException {
  const StorageException([String message = 'Something went wrong saving your data.'])
      : super(message);
}

/// A lookup by id (destination, booking, review...) came back empty.
class NotFoundException extends AppException {
  final String entity;
  final String id;
  NotFoundException(this.entity, this.id) : super('$entity with id "$id" was not found.');
}

/// Input failed a domain rule before it ever reached storage
/// (e.g. booking guests <= 0, empty required field, bad rating range).
class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// An action that needs a live connection (loading remote images,
/// a future sync call) was attempted while offline.
class NoConnectivityException extends AppException {
  const NoConnectivityException([String message = 'You appear to be offline. Check your connection and try again.'])
      : super(message);
}
