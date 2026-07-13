import 'package:flutter/material.dart';

import 'app.dart';
import 'services/hive_service.dart';
import 'services/seed_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive must be initialized (adapters registered, boxes opened) before
  // any repository touches it, and seeding must run before the first
  // provider.load() call — both awaited here, before runApp, so the very
  // first frame already has real data instead of a loading flash.
  await HiveService.init();
  await SeedService.seedIfNeeded();

  runApp(const TripGlideApp());
}
