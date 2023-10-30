import 'package:car_notes/data/reminders_database.dart';
import 'package:car_notes/domain/reminders_domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRemindersScreen extends StatefulWidget {
  static const id = "AddRemindersScreen";
  static RemindersDomain remindersDomain =
      RemindersDomain.withID(1, "some", -1, "10-30-23", "some");
  static bool editing = false;
  const AddRemindersScreen({super.key});

  @override
  State<AddRemindersScreen> createState() => _AddRemindersScreenState();
}

class _AddRemindersScreenState extends State<AddRemindersScreen> {
  bool _isClickedMileageToRemind = false;
  bool _isEnterReminderText = false;
  bool _isClickedAdditionalTextForReminder = false;
  RemindersDatabaseHelper _remindersDatabaseHelper = RemindersDatabaseHelper();

  static int serviceNumber = 0;
  static int finding = 0;

  List<String> serviceImages = [
    "assets/images/Air conditioning filter.jpeg",
    "assets/images/brake oil.webp",
    "assets/images/Brake pads.png",
    "assets/images/oil with filter.jpeg",
    "assets/images/Periodical maintenance.jpeg",
    "assets/images/Tire changing.jpeg",
  ];
  List<String> serviceNames = [
    "conditioning filter",
    "brake oil",
    "Brake pads",
    "oil with filter",
    "Periodical maintenance",
    "Tire changing",
  ];

  String reminderText = "";
  double mileageToRemind = -1;
  String date = "";
  String additionalTextForReminder = "";

  var txt = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _mileageController = TextEditingController();
  TextEditingController _additionalTextForReminder = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
    if (AddRemindersScreen.editing) {
      _mileageController.text =
          AddRemindersScreen.remindersDomain.mileageToRemind.toString();
      _dateController.text = AddRemindersScreen.remindersDomain.date;
      _additionalTextForReminder.text =
          AddRemindersScreen.remindersDomain.additionalTextForReminder;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _showBottomSheet();
      });
    }

    if (AddRemindersScreen.editing) {
      reminderText = AddRemindersScreen.remindersDomain.reminderText;
      mileageToRemind = AddRemindersScreen.remindersDomain.mileageToRemind;
      date = AddRemindersScreen.remindersDomain.date;
      additionalTextForReminder =
          AddRemindersScreen.remindersDomain.additionalTextForReminder;
    }
  }

  TextEditingController _reminderTextController() {
    if (AddRemindersScreen.editing) {
      txt.text = AddRemindersScreen.remindersDomain.reminderText;
    }
    return txt;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(
              Icons.cancel_outlined,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AddRemindersScreen.editing ? "Edit reminder" : "Add reminder",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  date = _dateController.text;
                  reminderText = txt.text;
                  if (reminderText.length != 0 &&
                      mileageToRemind > 0 &&
                      date.isNotEmpty) {
                    if (additionalTextForReminder.length != 0) {
                      if (AddRemindersScreen.editing) {
                        await _remindersDatabaseHelper.updateCarNote(
                          RemindersDomain(reminderText, mileageToRemind, date,
                              additionalTextForReminder),
                        );
                      } else {
                        await _remindersDatabaseHelper.insertReminders(
                          RemindersDomain(reminderText, mileageToRemind, date,
                              additionalTextForReminder),
                        );
                      }
                    } else {
                      additionalTextForReminder = " ";
                      if (AddRemindersScreen.editing) {
                        await _remindersDatabaseHelper.updateCarNote(
                          RemindersDomain(reminderText, mileageToRemind, date,
                              additionalTextForReminder),
                        );
                      } else {
                        await _remindersDatabaseHelper.insertReminders(
                          RemindersDomain(reminderText, mileageToRemind, date,
                              additionalTextForReminder),
                        );
                      }
                    }
                    Navigator.pop(context);
                  } else {}
                },
                icon: const Icon(
                  Icons.done,
                  size: 30,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.blueGrey[900],
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
                  child: Image.asset(
                    serviceImages[serviceNumber],
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
                        _isEnterReminderText == true
                            ? "Enter reminder text"
                            : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          controller:
                              finding < 0 ? null : (_reminderTextController()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: () {
                            setState(() {
                              _isEnterReminderText = true;
                              _isClickedAdditionalTextForReminder = false;
                              _isClickedMileageToRemind = false;
                            });
                          },
                          onChanged: (value) {
                            reminderText = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              _isEnterReminderText == true
                                  ? Icons.insert_page_break
                                  : null,
                              color: Colors.white,
                            ),
                            hintText: _isEnterReminderText == false
                                ? "Enter reminder text"
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
                        _isClickedMileageToRemind == true
                            ? "Mileage to remind"
                            : "",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _mileageController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: () {
                            setState(() {
                              _isEnterReminderText = false;
                              _isClickedMileageToRemind = true;
                              _isClickedAdditionalTextForReminder = false;
                            });
                          },
                          onChanged: (value) {
                            mileageToRemind = double.parse(value);
                          },
                          decoration: InputDecoration(
                            hintText: _isClickedMileageToRemind == false
                                ? "Mileage to remind"
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
                      Text(
                        _isClickedAdditionalTextForReminder == true
                            ? "Additional text for reminder"
                            : "",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _additionalTextForReminder,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: () {
                            setState(() {
                              _isEnterReminderText = false;
                              _isClickedMileageToRemind = false;
                              _isClickedAdditionalTextForReminder = true;
                            });
                          },
                          onChanged: (value) {
                            additionalTextForReminder = value;
                          },
                          decoration: InputDecoration(
                            hintText:
                                _isClickedAdditionalTextForReminder == false
                                    ? "Additional text for reminder"
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .7,
          color: Colors.black87,
          child: SingleChildScrollView(
            child: Column(
              children: bottomSheet(
                serviceNames: serviceNames,
                serviceImages: serviceImages,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> bottomSheet(
      {required List<String> serviceNames,
      required List<String> serviceImages}) {
    List<Widget> widgets = [];
    for (int i = 0; i < serviceImages.length; i++) {
      widgets.add(TextButton(
        onPressed: () {
          setState(() {
            serviceNumber = i;
            finding = i;
            txt.text = serviceNames[finding];
            Navigator.pop(context);
          });
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: Image.asset(serviceImages[i]),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                serviceNames[i],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ));
    }

    return widgets;
  }
}
