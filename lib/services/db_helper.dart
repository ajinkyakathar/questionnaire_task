import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    String path = join(await getDatabasesPath(), 'app.db');

    return openDatabase(path, version: 2, onCreate: (db, v) async {
      await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT,
        password TEXT
      )
      ''');

      await db.execute('''
      CREATE TABLE submissions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date TEXT,
        lat TEXT,
        long TEXT
      )
      ''');
    });
  }

  static Future registerUser(
      String name, String email, String phone, String pass) async {
    final dbClient = await db;
    await dbClient.delete('user');
    await dbClient.insert('user', {
      "name": name,
      "email": email,
      "phone": phone,
      "password": pass,
    });
  }

  static Future<Map<String, dynamic>?> loginUser(
      String phone, String pass) async {
    final dbClient = await db;
    final res = await dbClient.query(
      'user',
      where: "phone=? AND password=?",
      whereArgs: [phone, pass],
    );
    if (res.isNotEmpty) return res.first;
    return null;
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final dbClient = await db;
    final res = await dbClient.query('user');
    if (res.isNotEmpty) return res.first;
    return null;
  }

  static Future logout() async {
    final dbClient = await db;
    await dbClient.delete('user');
  }

  static Future saveSubmission(String title) async {
    final dbClient = await db;
    await dbClient.insert('submissions', {
      "title": title,
      "date": DateTime.now().toString(),
      "lat": "19.0760",
      "long": "72.8777"
    });
  }

  static Future<List<Map<String, dynamic>>> getSubmissions() async {
    final dbClient = await db;
    return dbClient.query('submissions', orderBy: "id DESC");
  }

  static Future<int> count() async {
    final dbClient = await db;
    final res = await dbClient.rawQuery("SELECT COUNT(*) FROM submissions");
    return Sqflite.firstIntValue(res) ?? 0;
  }
}