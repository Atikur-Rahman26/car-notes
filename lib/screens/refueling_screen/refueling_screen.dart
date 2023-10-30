import 'package:car_notes/constants.dart';
import 'package:car_notes/data/refueling_database.dart';
import 'package:car_notes/domain/refueling_domain.dart';
import 'package:car_notes/screens/add_refueling/add_refueling_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../setting_screen/setting_screen.dart';

class RefuelingScreen extends StatefulWidget {
  static const String id = "RefuelingScreen";
  const RefuelingScreen({super.key});
  @override
  State<RefuelingScreen> createState() => _RefuelingScreenState();
}

class _RefuelingScreenState extends State<RefuelingScreen> {
  late List<RefuelinDomain> refuelingList = [];
  RefuelingDatabaseHelper refuelingDatabaseHelper = RefuelingDatabaseHelper();
  int count = 0;
  String priceperLiterSign = "£\\L";

  List<int> _selectedIndices = [];
  List<int> _selectedId = [];
  bool _deletingState = false;
  int _searchBar = 0;

  Widget SearchBarClicked() {
    return SearchBar(
      hintText: "Search by name or company",
      onChanged: (String str) {},
    );
  }

  AppBar RefuelingScreenAppBar() {
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
      actions: RefuelingActionWidget(),
      backgroundColor: Colors.black45,
    );
  }

  List<Widget> RefuelingActionWidget() {
    {
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
            icon: Icon(Icons.oil_barrel),
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
  }

  AppBar RefuelingAppBar() {
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
                  _selectedId.clear();
                  _selectedIndices.clear();
                });
              },
            ),
            title: Text("selected:${_selectedIndices.length}"),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_selectedIndices.length == count) {
                      _selectedIndices.clear();
                      _selectedId.clear();
                    } else {
                      for (int i = 0; i < count; i++) {
                        if (_selectedIndices.contains(i)) {
                        } else {
                          _selectedIndices.add(i);
                          _selectedId.add(refuelingList[i].id);
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
                  bool _deleted =
                      await refuelingDatabaseHelper.deleteCarNote(_selectedId);
                  setState(() {
                    if (_deleted) {
                      _selectedId.clear();
                      _selectedIndices.clear();
                      if (_selectedId.length == 0) {
                        _deletingState = false;
                      }
                      if (_selectedIndices.length == 0) {
                        _deletingState = false;
                      }
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
        : RefuelingScreenAppBar();
  }

  List<Widget> getContainerList() {
    List<Widget> refuelingContainerList = [];
    for (int i = 0; i < count; i++) {
      refuelingContainerList.add(
        GestureDetector(
          onTap: () {
            if (_selectedIndices.isNotEmpty) {
              if (_selectedIndices.contains(i)) {
                if (_selectedId.contains(refuelingList[i].id)) {
                  setState(() {
                    _selectedIndices.remove(i);
                    _selectedId.remove(refuelingList[i].id);
                  });
                } else {
                  setState(() {
                    _selectedId.remove(refuelingList[i].id);
                  });
                }
              } else {
                if (_selectedId.contains(refuelingList[i].id)) {
                  _selectedId.remove(refuelingList[i].id);
                } else {
                  _selectedId.add(refuelingList[i].id);
                }
                setState(() {
                  _selectedIndices.add(i);
                });
              }
            } else {
              Navigator.pushNamed(context, AddRefueling.id);
            }
          },
          onLongPress: () {
            setState(() {
              _selectedIndices.add(i);
              _selectedId.add(refuelingList[i].id);
              _deletingState = true;
              RefuelingAppBar();
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "${refuelingList[i].date}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${refuelingList[i].time}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "${getStringStyling(text: refuelingList[i].mileage.toString())} km",
                            style: TextStyle(
                                color: Colors.purple[100],
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Text(
                        refuelingList[i].fuelType,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "${refuelingList[i].fuelTotalCost} £",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${refuelingList[i].pricePerLiter} $priceperLiterSign",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "${refuelingList[i].fuelVolume} L",
                            style: const TextStyle(
                                color: Colors.white,
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
    return refuelingContainerList;
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Scaffold(
      appBar: RefuelingAppBar(),
      backgroundColor: backgroundPrimaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRefueling.id);
        },
        child: Icon(Icons.oil_barrel_outlined),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: getContainerList(),
          ),
        ),
      ),
    );
  }

  void updateList() {
    final Future<Database> dbFuture =
        refuelingDatabaseHelper.initializeDatabase();

    dbFuture.then((database) {
      // Use a try-catch block to handle exceptions
      try {
        Future<List<RefuelinDomain>> tempRepairList =
            refuelingDatabaseHelper.getRefuelingList();

        tempRepairList.then((refuleList) {
          // Check if the widget is still mounted before updating the state
          if (mounted) {
            setState(() {
              this.refuelingList = refuleList;
              this.count = refuleList.length;
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
}
