import 'package:flutter/material.dart';

/// Resolves the string icon names stored on [Category] (Hive can't store
/// an `IconData` directly) to real Material icons. Add new mappings here
/// whenever a new category icon name is introduced in seed data.
class IconResolver {
  IconResolver._();

  static const Map<String, IconData> _icons = {
    'temple_buddhist': Icons.temple_buddhist_outlined,
    'account_balance': Icons.account_balance_outlined,
    'terrain': Icons.terrain_outlined,
    'location_city': Icons.location_city_outlined,
    'park': Icons.park_outlined,
    'waves': Icons.waves_outlined,
    'star': Icons.star_outline,
    'beach_access': Icons.beach_access_outlined,
  };

  static IconData resolve(String name) => _icons[name] ?? Icons.place_outlined;
}
