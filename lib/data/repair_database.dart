import 'dart:io';

import 'package:car_notes/domain/repair_domain.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RepairDatabaseHelper {
  static RepairDatabaseHelper? _repairDatabaseHelper;
  static Database? _database;
  RepairDatabaseHelper._createInstance();

  String repairTable = "repair_table";
  String repairId = 'id';
  String repairServiceName = "service_name";
  String repairTotalCosts = "total_costs";
  String repairLabourCosts = "labour_costs";
  String repairPartsCosts = "parts_costs";
  String repairMileage = "mileage";
  String repairVendorCodes = "vendor_codes";
  String repairDate = "date";
  String repairComment = "comment";

  factory RepairDatabaseHelper() {
    if (_repairDatabaseHelper == null) {
      _repairDatabaseHelper = RepairDatabaseHelper._createInstance();
    }
    return _repairDatabaseHelper!;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "/carNotes.db";
    var carNotesDatabase;
    try {
      carNotesDatabase =
          await openDatabase(path, version: 1, onCreate: _createDb);
    } on Exception catch (e) {
      print(e);
    }
    return carNotesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $repairTable ($repairId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$repairServiceName TEXT,$repairMileage INTEGER,$repairDate TEXT,'
        '$repairPartsCosts REAL,$repairLabourCosts REAL,$repairTotalCosts REAL,'
        '$repairVendorCodes TEXT,$repairComment TEXT)');
    print("Created 2");
  }

  Future<List<Map<String, dynamic>>> getRepairMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $repairTable order by $repairId ASC');
    result = await db.query(repairTable, orderBy: '$repairId ASC');
    return result;
  }

  Future<int> insertCarNote(RepairDomain repairDomain) async {
    var db = await this.database;
    var result = await db.insert(repairTable, repairDomain.toMap());
    return result;
  }

  Future<bool> deleteCarNote(List<int> deletingIndices) async {
    try {
      var db = await this.database;
      for (int i = 0; i < deletingIndices.length; i++) {
        await db.rawDelete(
            'DELETE FROM ${repairTable} WHERE $repairId=${deletingIndices[i]}');
      }
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<int> updateCarNote(RepairDomain repairDomain) async {
    var db = await this.database;
    var result = await db.update(repairTable, repairDomain.toMap());
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $repairTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<List<RepairDomain>> getRepairList() async {
    var refuelMapList = await getRepairMapList();
    int count = refuelMapList.length;
    List<RepairDomain> tempList = [];
    for (int i = 0; i < count; i++) {
      tempList.add(RepairDomain.fromMapObject(refuelMapList[i]));
    }
    return tempList;
  }
}
