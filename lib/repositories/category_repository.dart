import '../core/errors/app_exception.dart';
import '../models/category.dart';
import '../services/hive_service.dart';

/// Read-only repository for categories (categories are seeded once and not
/// user-editable in this version of the app, but CRUD is exposed for
/// completeness / future admin tooling).
class CategoryRepository {
  List<Category> getAll() {
    try {
      return HiveService.categoriesBox.values.toList();
    } catch (_) {
      throw const StorageException('Could not load categories.');
    }
  }

  Category? getById(String id) => HiveService.categoriesBox.get(id);

  Future<void> upsert(Category category) async {
    try {
      await HiveService.categoriesBox.put(category.id, category);
    } catch (_) {
      throw const StorageException('Could not save category.');
    }
  }

  Future<void> delete(String id) async {
    try {
      await HiveService.categoriesBox.delete(id);
    } catch (_) {
      throw const StorageException('Could not delete category.');
    }
  }
}
