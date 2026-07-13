import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';
import '../../models/category.dart';

class CategoryRepository {
  final _uuid = const Uuid();

  Box<Category> get _box => HiveBoxes.categories;

  List<Category> getAll() {
    try {
      return _box.values.toList();
    } on HiveError {
      throw const StorageException('Could not load categories.');
    }
  }

  Category getById(String id) {
    try {
      final match = _box.values.cast<Category?>().firstWhere((c) => c?.id == id, orElse: () => null);
      if (match == null) throw NotFoundException('Category', id);
      return match;
    } on HiveError {
      throw const StorageException('Could not read category.');
    }
  }

  Future<Category> add(Category category) async {
    if (category.name.trim().isEmpty) throw const ValidationException('Category name is required.');
    final withId = category.id.isEmpty ? category.copyWith(id: _uuid.v4()) : category;
    try {
      await _box.put(withId.id, withId);
      return withId;
    } on HiveError {
      throw const StorageException('Could not save category.');
    }
  }

  Future<void> delete(String id) async {
    try {
      await _box.delete(id);
    } on HiveError {
      throw const StorageException('Could not delete category.');
    }
  }

  Future<void> clearAll() async {
    try {
      await _box.clear();
    } on HiveError {
      throw const StorageException('Could not clear categories.');
    }
  }
}
