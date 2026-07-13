import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Thin wrapper around connectivity_plus.
///
/// All app *data* is local (Hive), so connectivity never blocks core
/// functionality — but network images (destination photos) and the
/// "Weather" panel on the details screen do need a connection, so the UI
/// surfaces a non-blocking "You're offline" banner when this reports false.
class ConnectivityService {
  final Connectivity _connectivity;
  ConnectivityService({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity();

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  Stream<bool> get onStatusChanged =>
      _connectivity.onConnectivityChanged.map(_hasConnection).distinct();

  bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
