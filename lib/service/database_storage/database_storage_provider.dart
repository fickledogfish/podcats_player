import 'dart:io' as io;

import 'package:flutter/foundation.dart' as fnd;
import 'package:sqflite/sqflite.dart' as sqf;

const String _preferencesTableName = 'user_preferences';
const String _storedFeedsTableName = 'podcasts';
const String _storedFeedItemsTableName = 'feed_items';

class DatabaseStorageProvider {
  static const _dbname = "podcats";
  static const _currentVersion = 1;

  final sqf.Database _connection;

  const DatabaseStorageProvider._({
    required sqf.Database connection,
  }) : _connection = connection;

  static Future<DatabaseStorageProvider> connect({
    String? path,
    String dbName = _dbname,
  }) async {
    final databasePath = await Future<String>(() {
      if (fnd.kDebugMode) {
        fnd.debugPrint(
          '⚠️ \x1B[31mRUNNING IN DEBUG MODE WITH IN-MEMORY DATABASE\x1B[0m',
        );
        return sqf.inMemoryDatabasePath;
      }

      if (path != null && path.isNotEmpty) {
        return path;
      }

      return _getDatabasePath().then((path) => _join(path, '$dbName.sqlite'));
    });

    final connection = await sqf.openDatabase(
      databasePath,
      version: _currentVersion,
      onCreate: _onCreate,
    );

    final provider = DatabaseStorageProvider._(
      connection: connection,
    );

    return provider;
  }

  Future<void> close() => _connection.close();

  Future<void> set() async {
    final result = await _connection.rawQuery('SELECT sql FROM sqlite_schema');
    print(result);
  }

  static Future<String> _getDatabasePath() async {
    if (io.Platform.isWindows || io.Platform.isLinux) {
      throw UnimplementedError();
    }

    return await sqf.getDatabasesPath();
  }

  static String _join(base, component) {
    if (io.Platform.isWindows) return "$base\\$component";

    return "$base/$component";
  }
}

Future<void> _onCreate(sqf.Database db, int version) async =>
    await Future.wait([
      _createPreferencesTable(db, version),
      _createFeedsTable(db, version),
      _createFeedItemsTable(db, version),
    ], eagerError: true);

Future<void> _createPreferencesTable(sqf.Database db, int version) async =>
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_preferencesTableName (\n'
      '    id INTEGER PRIMARY KEY AUTOINCREMENT\n'
      ')',
      [],
    );

Future<void> _createFeedsTable(sqf.Database db, int version) async =>
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_storedFeedsTableName (\n'
      '    id INTEGER PRIMARY KEY AUTOINCREMENT,\n'
      '    added_at INTEGER NOT NULL,\n'
      '    modified_at INTEGER NOT NULL,\n'
      '    type INTEGER NOT NULL\n'
      ')',
      [],
    );

Future<void> _createFeedItemsTable(sqf.Database db, int version) async =>
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_storedFeedItemsTableName (\n'
      '    id INTEGER PRIMARY KEY AUTOINCREMENT,\n'
      '    added_at INTEGER NOT NULL,\n'
      '    modified_at INTEGER NOT NULL,\n'
      '    parent INTEGER NOT NULL,\n'
      '\n'
      '    FOREIGN KEY(parent) REFERENCES $_storedFeedsTableName(id)\n'
      ')',
      [],
    );
