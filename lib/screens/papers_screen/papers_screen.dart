import 'package:car_notes/data/papers_database.dart';
import 'package:car_notes/domain/papers_domain.dart';
import 'package:car_notes/screens/add_papers/add_papers_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants.dart';
import '../setting_screen/setting_screen.dart';

class Papers extends StatefulWidget {
  static const String id = "Papers";
  const Papers({super.key});
  @override
  State<Papers> createState() => _PapersState();
}

class _PapersState extends State<Papers> {
  int _count = 0;
  List<int> _selectedIndices = [];
  List<int> _selectedId = [];
  bool _deletingState = false;
  int _searchBar = 0;
  late List<PapersDomain> repairList = [];
  PapersDatabaseHelper _papersDatabaseHelper = PapersDatabaseHelper();
  Widget SearchBarClicked() {
    return SearchBar(
      hintText: "Search by name or company",
      onChanged: (String str) {},
    );
  }

  AppBar PapersScreenAppBar() {
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
      actions: PapersScreenActionWidgets(),
      backgroundColor: Colors.black45,
    );
  }

  List<Widget> PapersScreenActionWidgets() {
    List<Widget> _temporaryActionWidget = [];
    if (_searchBar == 0) {
      _temporaryActionWidget.add(
        IconButton(
          onPressed: () {
            setState(() {
              _searchBar = 1;
            });
          },
          icon: Icon(Icons.search),
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
          icon: Icon(Icons.note_add_outlined),
        ),
      );
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

  AppBar PapersDeletingAppBar() {
    return AppBar(
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
                    _selectedId.add(repairList[i].id);
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

            bool isDeleted =
                await _papersDatabaseHelper.deletePapersNote(_selectedId);
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
    );
  }

  AppBar PapersAppBar() {
    return _deletingState ? PapersDeletingAppBar() : PapersScreenAppBar();
  }

  List<Widget> getContainerList() {
    List<Widget> repairingList = [];
    for (int i = 0; i < _count; i++) {
      repairingList.add(
        GestureDetector(
          onTap: () {
            if (_selectedIndices.isNotEmpty) {
              if (_selectedIndices.contains(i)) {
                if (_selectedId.contains(repairList[i].id)) {
                  setState(() {
                    _selectedIndices.remove(i);
                    _selectedId.remove(repairList[i].id);
                  });
                } else {
                  setState(() {
                    _selectedId.remove(repairList[i].id);
                  });
                }
              } else {
                if (_selectedId.contains(repairList[i].id)) {
                  _selectedId.remove(repairList[i].id);
                } else {
                  _selectedId.add(repairList[i].id);
                }
                setState(() {
                  _selectedIndices.add(i);
                });
              }
            } else {
              Navigator.pushNamed(context, AddPapersScreen.id);
            }
          },
          onLongPress: () {
            setState(() {
              _selectedIndices.add(i);
              _selectedId.add(repairList[i].id);
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
                                  "${repairList[i].date}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  repairList[i].documentName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${getStringStyling(text: repairList[i].mileage.toString())} km",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.purple[100],
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "${repairList[i].totalCost} £",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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

  void updateList() {
    final Future<Database> dbFuture =
        _papersDatabaseHelper.initializeDatabase();

    dbFuture.then((database) {
      // Use a try-catch block to handle exceptions
      try {
        Future<List<PapersDomain>> tempRepairList =
            _papersDatabaseHelper.getPapersList();

        tempRepairList.then((repairList) {
          // Check if the widget is still mounted before updating the state
          if (mounted) {
            setState(() {
              this.repairList = repairList;
              this._count = repairList.length;
            });
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

  @override
  Widget build(BuildContext context) {
    updateList();
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPapersScreen.id);
        },
        child: Icon(Icons.note_add_outlined),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getContainerList(),
        ),
      ),
      appBar: PapersAppBar(),
    );
  }
}
