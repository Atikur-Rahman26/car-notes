import 'dart:io';

import 'package:car_notes/domain/reminders_domain.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RemindersDatabaseHelper {
  static RemindersDatabaseHelper? _remindersDatabaseHelper;
  static Database? _database;
  RemindersDatabaseHelper._createInstance();

  String remindersTable = "reminders_table";
  String reminderId = 'id';
  String remindersReminderText = "reminder_text";
  String remindersMileageToRemind = "mileage_to_remind";
  String remindersDate = "date";
  String remindersAdditionalTextForReminder = "additional_text_for_reminder";

  factory RemindersDatabaseHelper() {
    if (_remindersDatabaseHelper == null) {
      _remindersDatabaseHelper = RemindersDatabaseHelper._createInstance();
    }
    return _remindersDatabaseHelper!;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "carNote_remindersTable.db";

    var remindersDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return remindersDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $remindersTable ($reminderId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$remindersReminderText TEXT,$remindersMileageToRemind REAL,$remindersDate TEXT,'
        '$remindersAdditionalTextForReminder TEXT)');
    print("Created 2");
  }

  Future<List<Map<String, dynamic>>> getRemindersMapList() async {
    Database db = await this.database;
    var result = await db
        .rawQuery('SELECT * FROM $remindersTable order by $reminderId ASC');
    result = await db.query(remindersTable, orderBy: '$reminderId ASC');
    return result;
  }

  Future<int> insertReminders(RemindersDomain remindersDomain) async {
    var db = await this.database;
    var result = await db.insert(remindersTable, remindersDomain.toMap());
    return result;
  }

  Future<bool> deleteReminders(List<int> deletingIndices) async {
    try {
      var db = await this.database;
      for (int i = 0; i < deletingIndices.length; i++) {
        await db.rawDelete(
            'DELETE FROM ${remindersTable} WHERE $reminderId=${deletingIndices[i]}');
      }
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<int> updateCarNote(RemindersDomain remindersDomain) async {
    var db = await this.database;
    var result = await db.update(remindersTable, remindersDomain.toMap());
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $remindersTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<List<RemindersDomain>> getPapersList() async {
    var remindrsMapList = await getRemindersMapList();
    int count = remindrsMapList.length;
    List<RemindersDomain> tempList = [];
    for (int i = 0; i < count; i++) {
      tempList.add(RemindersDomain.fromMapObject(remindrsMapList[i]));
    }
    return tempList;
  }
}
