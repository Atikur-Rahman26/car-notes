import 'dart:io';

import 'package:car_notes/domain/refueling_domain.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RefuelingDatabaseHelper {
  static RefuelingDatabaseHelper? _refuelingDatabaseHelper;
  static Database? _database;
  RefuelingDatabaseHelper._createInstance();

  String refuelingTable = "refuel_table";
  String refuelId = 'id';
  String refuelFuelType = "fuel_type";
  String refuelFuelTotalCost = "fuel_total_cost";
  String refuelPricePerLiter = "price_per_liter";
  String refuelFuelVolume = "fuel_volume";
  String refuelFullTank = "full_tank";
  String refuelMileage = "mileage";
  String refuelDate = "date";
  String refuelTime = "time";
  String refuelComment = "comment";

  factory RefuelingDatabaseHelper() {
    if (_refuelingDatabaseHelper == null) {
      _refuelingDatabaseHelper = RefuelingDatabaseHelper._createInstance();
    }
    return _refuelingDatabaseHelper!;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "carNotes.db";
    var carNotesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return carNotesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $refuelingTable($refuelId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$refuelFuelType TEXT,$refuelFuelTotalCost REAL,$refuelPricePerLiter REAL,'
        '$refuelFuelVolume REAL,$refuelFullTank INTEGER,$refuelMileage INTEGER,'
        '$refuelDate TEXT,$refuelTime TEXT,$refuelComment TEXT)');
  }

  Future<List<Map<String, dynamic>>> getRefuelingMapList() async {
    Database db = await this.database;
    var result = await db
        .rawQuery('SELECT * FROM $refuelingTable order by $refuelId ASC');
    result = await db.query(refuelingTable, orderBy: '$refuelId ASC');
    return result;
  }

  Future<int> insertCarNote(RefuelinDomain refuelinDomain) async {
    var db = await this.database;
    var result = await db.insert(refuelingTable, refuelinDomain.toMap());
    return result;
  }

  Future<bool> deleteCarNote(List<int> deletingIndices) async {
    try {
      var db = await this.database;
      for (int i = 0; i < deletingIndices.length; i++) {
        await db.rawDelete(
            'DELETE FROM ${refuelingTable} WHERE $refuelId=${deletingIndices[i]}');
      }
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<int> updateCarNote(RefuelinDomain refuelinDomain) async {
    var db = await this.database;
    var result = await db.update(refuelingTable, refuelinDomain.toMap());
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $refuelingTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<List<RefuelinDomain>> getRefuelingList() async {
    var refuelMapList = await getRefuelingMapList();
    int count = refuelMapList.length;
    List<RefuelinDomain> tempList = [];
    for (int i = 0; i < count; i++) {
      tempList.add(RefuelinDomain.fromMapObject(refuelMapList[i]));
    }
    return tempList;
  }
}
