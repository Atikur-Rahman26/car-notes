import 'package:car_notes/data/refueling_database.dart';
import 'package:car_notes/domain/refueling_domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRefueling extends StatefulWidget {
  static const String id = "AddRefueling";
  const AddRefueling({super.key});

  @override
  State<AddRefueling> createState() => _AddRefuelingState();
}

class _AddRefuelingState extends State<AddRefueling> {
  //Variables
  late double fuelCost;
  late String fuelType;
  late double pricePerLiter;
  late double fuelVolume;
  late int fullTank;
  late int mileage;
  late String date;
  late String time;
  late String comment;

  RefuelingDatabaseHelper refuelingDatabaseHelper = RefuelingDatabaseHelper();

  TextEditingController _textEditingController = TextEditingController();
  List<String> _allDropdownItems = [
    'Regular',
    'Plus',
    'Premium',
    'Super',
    'Diesel',
    'Natural Gas',
    'LPG',
  ];
  List<String> _filteredDropdownItems = [];
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      });
    }
  }

  TextEditingController _timeController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _formatTime(_selectedTime);
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  void initState() {
    super.initState();
    final currentTime = DateFormat('h:mm a').format(DateTime.now());
    _textEditingController.addListener(() {
      setState(() {
        _filteredDropdownItems =
            _filterDropdownItems(_textEditingController.text);
      });
    });
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
    _timeController.text = (currentTime);
  }

  List<String> _filterDropdownItems(String query) {
    return _allDropdownItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  String _fuelTotalCost = "";
  bool _isClicked = false;
  bool _isClickedFuelType = false;
  bool _isClickedPricePerLiter = false;
  bool _isClickedFuelVolume = false;
  bool _isClickedMileage = false;
  bool _isClickedDate = false;
  bool _isClickedComment = false;
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          backgroundColor: Colors.black45,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel_outlined),
            iconSize: 35,
          ),
          title: const Text(
            "Add Refueling",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                fullTank = _isSwitched == true ? 1 : 0;
                date = _dateController.text;
                time = _timeController.text;
                await refuelingDatabaseHelper.insertCarNote(
                  RefuelinDomain(
                    fuelType,
                    fuelCost,
                    pricePerLiter,
                    fuelVolume,
                    fullTank,
                    mileage,
                    date,
                    time,
                    comment,
                  ),
                );
                print("done adding");
                Navigator.pop(context);
              },
              icon: const Icon(Icons.done),
              iconSize: 35,
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: 10,
          ),
          color: Colors.black54,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15),
                  height: 100,
                  width: double.infinity,
                  child: Image.asset("assets/images/refueling.png"),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClicked == true ? "Fuel total cost" : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: () {
                            setState(() {
                              _isClicked = true;
                              _isClickedFuelType = false;
                              _isClickedPricePerLiter = false;
                              _isClickedFuelVolume = false;
                              _isClickedMileage = false;
                              _isClickedDate = false;
                            });
                          },
                          onChanged: (value) {
                            fuelCost = double.tryParse(value)!;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              _isClicked == true
                                  ? Icons.currency_exchange_rounded
                                  : null,
                              color: Colors.white,
                            ),
                            hintText:
                                _isClicked == false ? "Fuel total cost" : "",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.blueGrey[900],
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedFuelType == true ? "Fuel type" : "",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                        controller: _textEditingController,
                        onChanged: (value) {
                          fuelType = value;
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          hintText:
                              _isClickedFuelType == false ? 'Fuel type' : null,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                        ),
                        onTap: () {
                          setState(() {
                            fuelType = _textEditingController.text;
                            print(fuelType);
                            _isClickedFuelType = true;
                            _isClicked = false;
                            _isClickedPricePerLiter = false;
                            _isClickedMileage = false;
                            _isClickedDate = false;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      ((_isClickedFuelType == true &&
                              _filteredDropdownItems.isNotEmpty))
                          ? Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filteredDropdownItems.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    textColor: Colors.white70,
                                    title: Text(_filteredDropdownItems[index]),
                                    onTap: () {
                                      setState(() {
                                        _textEditingController.text =
                                            _filteredDropdownItems[index];
                                        _filteredDropdownItems.clear();
                                        fuelType = _textEditingController.text;
                                      });
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedPricePerLiter == true
                            ? "Price per liter"
                            : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            pricePerLiter = double.tryParse(value)!;
                          },
                          onTap: () {
                            setState(() {
                              _isClicked = false;
                              _isClickedFuelType = false;
                              _isClickedPricePerLiter = true;
                              _isClickedFuelVolume = false;
                              _isClickedMileage = false;
                              _isClickedDate = false;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.currency_pound,
                              color: Colors.white70,
                            ),
                            hintText: _isClickedPricePerLiter == false
                                ? "Price per liter"
                                : "",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedFuelVolume == true ? "Fuel volume" : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: () {
                            setState(() {
                              _isClicked = false;
                              _isClickedFuelType = false;
                              _isClickedPricePerLiter = false;
                              _isClickedFuelVolume = true;
                              _isClickedMileage = false;
                              _isClickedDate = false;
                            });
                          },
                          onChanged: (value) {
                            fuelVolume = double.tryParse(value)!;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              _isClickedFuelVolume == true
                                  ? Icons.oil_barrel_outlined
                                  : null,
                              color: Colors.white,
                            ),
                            hintText: _isClickedFuelVolume == false
                                ? "Fuel volume"
                                : "",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          "Full tank (needed for average fuel consumption calculation)",
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                          maxLines: 2,
                        ),
                      ),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                            print(_isSwitched);
                          });
                        },
                        activeTrackColor: Colors.lightGreen,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedMileage == true ? "Mileage" : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            mileage = int.tryParse(value)!;
                          },
                          onTap: () {
                            setState(() {
                              _isClicked = false;
                              _isClickedFuelType = false;
                              _isClickedPricePerLiter = false;
                              _isClickedFuelVolume = false;
                              _isClickedMileage = true;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              _isClicked == true
                                  ? Icons.currency_exchange_rounded
                                  : null,
                              color: Colors.white,
                            ),
                            hintText:
                                _isClickedMileage == false ? "Mileage" : "",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Date",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () => _selectDate(context),
                        child: IgnorePointer(
                          child: TextField(
                            style: TextStyle(color: Colors.white70),
                            controller: _dateController,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Time",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectTime(context),
                          child: IgnorePointer(
                            child: TextField(
                              style: TextStyle(color: Colors.white70),
                              controller: _timeController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.blueGrey[900],
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedComment == true ? "Comment" : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            comment = value;
                          },
                          onTap: () {
                            setState(() {
                              _isClicked = false;
                              _isClickedFuelType = false;
                              _isClickedPricePerLiter = false;
                              _isClickedFuelVolume = false;
                              _isClickedMileage = false;
                              _isClickedDate = false;
                              _isClickedComment = true;
                            });
                          },
                          decoration: InputDecoration(
                            hintText:
                                _isClickedComment == false ? "Comment" : "",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
