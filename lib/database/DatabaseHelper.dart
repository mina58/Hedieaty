import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // The database instance should be a singleton
  static Database? _database;

  // Private constructor to ensure no external instantiation
  DatabaseHelper._privateConstructor();

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // The actual database object
  Future<Database> get database async {
    // If the database is not initialized, open it
    _database ??= await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the directory to store the database file
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'hedieaty.db');

    // Open the database and create the table if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the tables here
        await db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          phone TEXT NOT NULL,
          imageURL TEXT NOT NULL
        );
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          date DATE NOT NULL,
          owner_id TEXT NOT NULL,
          FOREIGN KEY (owner_id) REFERENCES users (id) ON DELETE CASCADE
        );
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS gifts( 
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          price INTEGER NOT NULL,
          description TEXT NOT NULL,
          category TEXT NOT NULL,
          image_url TEXT NOT NULL,
          event_id INTEGER NOT NULL,
          FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE
        );
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS friends (
          user_id TEXT,
          friend_id TEXT,
          PRIMARY KEY (user_id, friend_id),
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
          FOREIGN KEY (friend_id) REFERENCES users (id) ON DELETE CASCADE
        );
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS notifications(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT NOT NULL,
          title TEXT NOT NULL,
          message TEXT NOT NULL,
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
        );
      ''');

        // Enable foreign key constraints
        await db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }
}
