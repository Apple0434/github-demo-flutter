import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountDatabase {
  static final AccountDatabase instance = AccountDatabase._init();
  static Database? _database;

  AccountDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('accounts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  /// 🟢 Dùng trong màn đăng ký (giống cách cũ)
  Future<void> saveAccount(Map<String, String> account) async {
    final db = await instance.database;

    final existing = await db.query(
      'accounts',
      where: 'username = ?',
      whereArgs: [account['username']],
    );

    if (existing.isNotEmpty) {
      throw Exception('Tài khoản đã tồn tại');
    }

    await db.insert('accounts', {
      'username': account['username'],
      'password': account['password'],
      'email': account['email'],
    });
  }

  /// 🟡 Kiểm tra đăng nhập
  Future<bool> checkLogin(String username, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'accounts',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  /// 🔵 Lấy toàn bộ tài khoản (nếu cần debug hoặc admin)
  Future<List<Map<String, dynamic>>> getAllAccounts() async {
    final db = await instance.database;
    return await db.query('accounts');
  }

  /// 🔴 Đóng DB
  Future<void> close() async {
    final db = await _database;
    db?.close();
  }
}
