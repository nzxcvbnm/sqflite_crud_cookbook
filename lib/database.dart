import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'recipe.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static const databaseName = 'recipes_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, content TEXT)");
    });
  }

  insertRecipe(Recipe recipe) async {
    final db = await database;
    var res = await db.insert(Recipe.TABLENAME, recipe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Recipe>> retrieveRecipes() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Recipe.TABLENAME);

    return List.generate(maps.length, (i) {
      return Recipe(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }

  updateRecipe(Recipe recipe) async {
    final db = await database;

    await db.update(Recipe.TABLENAME, recipe.toMap(),
        where: 'id = ?',
        whereArgs: [recipe.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteRecipe(int id) async {
    var db = await database;
    db.delete(Recipe.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}