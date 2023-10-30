import 'package:car_notes/data/reminders_database.dart';
import 'package:car_notes/domain/reminders_domain.dart';
import 'package:car_notes/screens/add_reminders/add_reminders_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants.dart';
import '../setting_screen/setting_screen.dart';

class Reminders extends StatefulWidget {
  static const String id = "Reminders";
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  RemindersDatabaseHelper _remindersDatabaseHelper = RemindersDatabaseHelper();
  bool _deletingState = false;
  int _searchBar = 0;
  int _count = 0;
  List<int> _selectedIndices = [];
  List<int> _selectedId = [];
  List<RemindersDomain> reminderList = [];

  Widget SearchBarClicked() {
    return SearchBar(
      hintText: "Search by name or company",
      onChanged: (String str) {},
    );
  }

  AppBar RemindersDefaultAppBar() {
    return AppBar(
      elevation: 1,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SettingScreen.id);
            },
            icon: Icon(Icons.settings),
          );
        },
      ),
      title: _searchBar == 0 ? Text("Car Notes") : SearchBarClicked(),
      actions: RemindersActionWidget(),
      backgroundColor: Colors.black45,
    );
  }

  List<Widget> RemindersActionWidget() {
    List<Widget> _temporaryActionWidget = [];
    if (_searchBar == 0) {
      {
        _temporaryActionWidget.add(
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                child: Text("by percent"),
                value: "byPercent",
              ),
              PopupMenuItem(
                child: Text("by date"),
                value: "byDate",
              ),
              PopupMenuItem(
                child: Text("by mileage"),
                value: "byMileage",
              ),
            ],
            onSelected: (value) {},
            child: Icon(Icons.sort),
          ),
        );
        _temporaryActionWidget.add(
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.directions_car_outlined),
          ),
        );
        _temporaryActionWidget.add(
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notification_add),
          ),
        );
      }
    } else {
      _temporaryActionWidget.add(
        IconButton(
          onPressed: () {
            setState(() {
              _searchBar = 0;
            });
          },
          icon: Icon(Icons.cancel_outlined),
        ),
      );
    }
    return _temporaryActionWidget;
  }

  AppBar RemindersAppBar() {
    return _deletingState
        ? AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _deletingState = false;
                  _selectedIndices.clear();
                  _selectedId.clear();
                });
              },
            ),
            title: Text("selected:${_selectedIndices.length}"),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_selectedIndices.length == _count) {
                      _selectedId.clear();
                      _selectedIndices.clear();
                    } else {
                      for (int i = 0; i < _count; i++) {
                        if (_selectedIndices.contains(i))
                          ;
                        else {
                          _selectedIndices.add(i);
                          _selectedId.add(reminderList[i].id);
                        }
                      }
                    }
                  });
                },
                icon: const Icon(
                  Icons.select_all_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () async {
                  print(_selectedId);
                  print(_selectedIndices);

                  bool isDeleted = await _remindersDatabaseHelper
                      .deleteReminders(_selectedId);
                  setState(() {
                    if (isDeleted) {
                      _selectedId.clear();
                      _selectedIndices.clear();
                      if (_selectedId.length == 0) {
                        _deletingState = false;
                      }
                      if (_selectedIndices.length == 0) {
                        _deletingState = false;
                      }
                      print(_deletingState);
                    }
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          )
        : RemindersDefaultAppBar();
  }

  void updateList() {
    final Future<Database> dbFuture =
        _remindersDatabaseHelper.initializeDatabase();

    dbFuture.then((database) {
      // Use a try-catch block to handle exceptions
      try {
        Future<List<RemindersDomain>> tempRepairList =
            _remindersDatabaseHelper.getPapersList();

        tempRepairList.then((remindersList) {
          // Check if the widget is still mounted before updating the state
          if (mounted) {
            setState(() {
              this.reminderList = remindersList;
              this._count = remindersList.length;
            });
            print(_count);
          }
        }).catchError((error) {
          // Handle any errors that occur during database retrieval
          print("Error retrieving data from the database: $error");
        });
      } catch (error) {
        // Handle any exceptions that occur during database operations
        print("Exception in database operations: $error");
      }
    }).catchError((error) {
      // Handle any errors that occur during database initialization
      print("Error initializing the database: $error");
    });
  }

  List<Widget> getContainerList() {
    List<Widget> repairingList = [];
    for (int i = 0; i < _count; i++) {
      repairingList.add(
        GestureDetector(
          onTap: () {
            if (_selectedIndices.isNotEmpty) {
              if (_selectedIndices.contains(i)) {
                if (_selectedId.contains(reminderList[i].id)) {
                  setState(() {
                    _selectedIndices.remove(i);
                    _selectedId.remove(reminderList[i].id);
                  });
                } else {
                  setState(() {
                    _selectedId.remove(reminderList[i].id);
                  });
                }
              } else {
                if (_selectedId.contains(reminderList[i].id)) {
                  _selectedId.remove(reminderList[i].id);
                } else {
                  _selectedId.add(reminderList[i].id);
                }
                setState(() {
                  _selectedIndices.add(i);
                });
              }
            } else {
              AddRemindersScreen.editing = true;
              AddRemindersScreen.remindersDomain = RemindersDomain.withID(
                  reminderList[i].id,
                  reminderList[i].reminderText,
                  reminderList[i].mileageToRemind,
                  reminderList[i].date,
                  reminderList[i].additionalTextForReminder);
              Navigator.pushNamed(context, AddRemindersScreen.id);
            }
          },
          onLongPress: () {
            setState(() {
              _selectedIndices.add(i);
              _selectedId.add(reminderList[i].id);
              _deletingState = true;
            });
          },
          child: Container(
            height: 100,
            width: double.infinity,
            margin: EdgeInsets.only(left: 5, right: 5, top: 5),
            color:
                _selectedIndices.contains(i) ? Colors.cyan : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.only(right: 5),
                  child: Image.asset(
                    "assets/images/refueling.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${reminderList[i].reminderText}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "0%",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "${reminderList[i].date} ",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${getStringStyling(text: reminderList[i].mileageToRemind.toString())} km",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.purple[100],
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return repairingList;
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRemindersScreen.id);
        },
        child: Icon(Icons.notification_add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getContainerList(),
        ),
      ),
      appBar: RemindersAppBar(),
    );
  }
}
