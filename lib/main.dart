import 'package:flutter/material.dart';
import 'app.dart';
import 'services/hive_service.dart';
import 'services/seed_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await SeedService.seedIfNeeded();
  runApp(const TripGlideApp());
}
