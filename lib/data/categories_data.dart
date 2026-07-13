import '../models/category.dart';

/// Seed categories shown as filter chips on the Home screen, matching the
/// continent-based filtering in the design reference (Asia, Europe, South
/// America, ...).
const List<Category> seedCategories = [
  Category(id: 'cat_asia', name: 'Asia', icon: 'temple_buddhist'),
  Category(id: 'cat_europe', name: 'Europe', icon: 'account_balance'),
  Category(id: 'cat_south_america', name: 'South America', icon: 'terrain'),
  Category(id: 'cat_north_america', name: 'North America', icon: 'location_city'),
  Category(id: 'cat_africa', name: 'Africa', icon: 'park'),
  Category(id: 'cat_oceania', name: 'Oceania', icon: 'waves'),
];
