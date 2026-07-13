import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../core/exceptions.dart';
import '../../core/hive_boxes.dart';
import '../../models/destination.dart';

class DestinationRepository {
  final _uuid = const Uuid();

  Box<Destination> get _box => HiveBoxes.destinations;

  List<Destination> getAll() {
    try {
      return _box.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } on HiveError {
      throw const StorageException('Could not load destinations.');
    }
  }

  Destination getById(String id) {
    final result = _find(id);
    if (result == null) throw NotFoundException('Destination', id);
    return result;
  }

  Destination? _find(String id) {
    try {
      return _box.values.cast<Destination?>().firstWhere((d) => d?.id == id, orElse: () => null);
    } on HiveError {
      throw const StorageException('Could not read destination.');
    }
  }

  List<Destination> getByCategory(String categoryId) {
    return getAll().where((d) => d.categoryId == categoryId).toList();
  }

  List<Destination> search(String query) {
    if (query.trim().isEmpty) return getAll();
    final q = query.trim().toLowerCase();
    return getAll().where((d) {
      return d.city.toLowerCase().contains(q) ||
          d.country.toLowerCase().contains(q) ||
          d.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  List<Destination> getFeatured({int limit = 5}) {
    final all = getAll()..sort((a, b) => b.rating.compareTo(a.rating));
    return all.take(limit).toList();
  }

  Future<Destination> add(Destination destination) async {
    _validate(destination);
    final withId = destination.id.isEmpty ? destination.copyWith(id: _uuid.v4()) : destination;
    try {
      await _box.put(withId.id, withId);
      return withId;
    } on HiveError {
      throw const StorageException('Could not save destination.');
    }
  }

  Future<Destination> update(Destination destination) async {
    _validate(destination);
    if (_find(destination.id) == null) {
      throw NotFoundException('Destination', destination.id);
    }
    try {
      await _box.put(destination.id, destination);
      return destination;
    } on HiveError {
      throw const StorageException('Could not update destination.');
    }
  }

  Future<void> delete(String id) async {
    if (_find(id) == null) throw NotFoundException('Destination', id);
    try {
      await _box.delete(id);
    } on HiveError {
      throw const StorageException('Could not delete destination.');
    }
  }

  Future<void> clearAll() async {
    try {
      await _box.clear();
    } on HiveError {
      throw const StorageException('Could not clear destinations.');
    }
  }

  void _validate(Destination d) {
    if (d.city.trim().isEmpty) throw const ValidationException('City is required.');
    if (d.country.trim().isEmpty) throw const ValidationException('Country is required.');
    if (d.pricePerPerson < 0) throw const ValidationException('Price cannot be negative.');
    if (d.rating < 0 || d.rating > 5) throw const ValidationException('Rating must be between 0 and 5.');
  }
}
