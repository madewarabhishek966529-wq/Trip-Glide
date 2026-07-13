import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:myapp/core/exceptions.dart';

/// Thin wrapper around connectivity_plus so the rest of the app depends on
/// this interface, not the package directly (easier to fake in tests).
class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  /// One-shot check.
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  /// Live stream for the "no internet" banner to subscribe to.
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  /// Throws [NoConnectivityException] if currently offline.
  /// Call this at the top of any action that genuinely needs a network
  /// (remote image refresh, future sync) — NOT for plain local Hive reads.
  Future<void> requireConnection() async {
    if (!await isConnected) {
      throw const NoConnectivityException();
    }
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }
}
