import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import "package:path/path.dart";
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:waitress_app/core/domain/entities/orders.dart';
import 'package:waitress_app/core/domain/entities/product.dart';

abstract class AppStorage {
  Future<List<Product>> getAllProducts();
  Future<List<TableOrder>> getInactiveTableOrder();
  Future<Map<int, TableOrder>> getActiveTableOrder();
  Future<bool> setTableInactive({
    required int tableNumber,
  });
  Future<bool> createNewOrder({
    required int tableNumber,
    required List<String> choosenProductIds,
  });
  Future<bool> addProductsToTable({
    required int tableNumber,
    required List<String> choosenProductIds,
  });
}

@Injectable(as: AppStorage)
class AppStorageImpl implements AppStorage {
  static late Database _database;
  static const String _productsTableName = 'products';
  static const String _ordersTableName = 'orders';

  static Future init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'restaraunt.db'),
      onCreate: (db, version) async {
        db.execute(
          'CREATE TABLE $_productsTableName('
          'id TEXT PRIMARY KEY,'
          'name TEXT,'
          'filename TEXT)',
        );

        String jsonString =
            await rootBundle.loadString('assets/json/products.json');
        List<dynamic> jsonResponse = json.decode(jsonString);
        for (var product in jsonResponse) {
          await db.insert(
            _productsTableName,
            {
              'id': product['id'],
              'name': product['name'],
              'filename': product['filename'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        db.execute(
          'CREATE TABLE $_ordersTableName('
          'timestamp INTEGER PRIMARY KEY,'
          'table_number INTEGER,'
          'is_active INTEGER,'
          'product_ids TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<Map<int, TableOrder>> getActiveTableOrder() async {
    final List<Map<String, dynamic>> orderMaps = await _database.query(
      _ordersTableName,
      where: 'is_active = ?',
      whereArgs: [1],
    );

    final list = List.generate(orderMaps.length, (i) {
      return TableOrder.fromMap(orderMaps[i]);
    });

    return {for (var order in list) order.tableNumber: order};
  }

  @override
  Future<List<TableOrder>> getInactiveTableOrder() async {
    final List<Map<String, dynamic>> orderMaps = await _database.query(
      _ordersTableName,
      where: 'is_active = ?',
      whereArgs: [0],
    );

    return List.generate(orderMaps.length, (i) {
      return TableOrder.fromMap(orderMaps[i]);
    });
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final List<Map<String, dynamic>> productMaps =
        await _database.query(_productsTableName);

    return List.generate(productMaps.length, (i) {
      return Product.fromMap(productMaps[i]);
    });
  }

  @override
  Future<bool> createNewOrder({
    required int tableNumber,
    required List<String> choosenProductIds,
  }) async {
    try {
      final order = TableOrder(
        timestamp: DateTime.now().millisecondsSinceEpoch,
        tableNumber: tableNumber,
        isActive: true,
        productIds: choosenProductIds,
      );

      await _database.insert(
        'orders',
        order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> setTableInactive({
    required int tableNumber,
  }) async {
    await _database.update(
      _ordersTableName,
      {'is_active': 0},
      where: 'table_number = ? AND is_active = ?',
      whereArgs: [tableNumber, 1],
    );
    return true;
  }

  @override
  Future<bool> addProductsToTable({
    required int tableNumber,
    required List<String> choosenProductIds,
  }) async {
    List<Map<String, dynamic>> results = await _database.query(
      _ordersTableName,
      where: 'table_number = ? AND is_active = ?',
      whereArgs: [tableNumber, 1],
    );
    if (results.isEmpty) return false;
    String currentProductIds = results[0]['product_ids'] ?? '';
    List<String> productIdsList =
        currentProductIds.isNotEmpty ? currentProductIds.split(',') : [];

    productIdsList.addAll(choosenProductIds);

    await _database.update(
      _ordersTableName,
      {'product_ids': productIdsList.join(',')},
      where: 'table_number = ? AND is_active = ?',
      whereArgs: [tableNumber, 1],
    );
    return true;
  }
}
