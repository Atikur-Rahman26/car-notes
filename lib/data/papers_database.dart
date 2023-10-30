import 'dart:io';

import 'package:car_notes/domain/papers_domain.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PapersDatabaseHelper {
  static PapersDatabaseHelper? _papersDatabaseHelper;
  static Database? _database;
  PapersDatabaseHelper._createInstance();

  String papersTable = "papers_table";
  String papersId = 'id';
  String papersDocumentName = "document_name";
  String papersTotalCosts = "total_cost";
  String papersMileage = "mileage";
  String papersDate = "date";
  String papersComment = "comment";

  factory PapersDatabaseHelper() {
    if (_papersDatabaseHelper == null) {
      _papersDatabaseHelper = PapersDatabaseHelper._createInstance();
    }
    return _papersDatabaseHelper!;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "/carNote.db";

    var carNotesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return carNotesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    print("has come");
    await db.execute(
        'CREATE TABLE $papersTable ($papersId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$papersDocumentName TEXT,$papersMileage INTEGER,$papersDate TEXT,'
        '$papersTotalCosts REAL,$papersComment TEXT)');
    print("Created 2");
  }

  Future<List<Map<String, dynamic>>> getPapersMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $papersTable order by $papersId ASC');
    result = await db.query(papersTable, orderBy: '$papersId ASC');
    return result;
  }

  Future<int> insertPaper(PapersDomain papersDomain) async {
    var db = await this.database;
    var result = await db.insert(papersTable, papersDomain.toMap());
    return result;
  }

  Future<bool> deletePapersNote(List<int> deletingIndices) async {
    try {
      var db = await this.database;
      for (int i = 0; i < deletingIndices.length; i++) {
        await db.rawDelete(
            'DELETE FROM ${papersTable} WHERE $papersId=${deletingIndices[i]}');
      }
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<int> updateCarNote(PapersDomain papersDomain) async {
    var db = await this.database;
    var result = await db.update(papersTable, papersDomain.toMap());
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $papersTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<List<PapersDomain>> getPapersList() async {
    var papersMapList = await getPapersMapList();
    int count = papersMapList.length;
    List<PapersDomain> tempList = [];
    for (int i = 0; i < count; i++) {
      tempList.add(PapersDomain.fromMapObject(papersMapList[i]));
    }
    return tempList;
  }
}
