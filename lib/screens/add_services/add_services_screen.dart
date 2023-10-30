import 'package:car_notes/data/repair_database.dart';
import 'package:car_notes/domain/repair_domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddServiceScreen extends StatefulWidget {
  static const id = "AddServiceScreen";
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  static int serviceNumber = 0;
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
  static int finding = -1;
  RepairDatabaseHelper repairDatabaseHelper = RepairDatabaseHelper();

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showBottomSheet();
    });
  }

  var txt = TextEditingController();

  bool _isClickedServiceName = false;
  bool _isClickedMileage = false;
  bool _isClickedParts = false;
  bool _isClickedLabour = false;
  bool _isClickedTotal = false;
  bool _isClickedVendorCodes = false;
  bool _isClickedComment = false;

  String _serviceName = "";
  int _mileage = 0;
  String _date = "";
  double _partsCost = 0;
  double _labourCost = 0;
  double _totalCost = 0;
  String _vendorCodes = "";
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Add Repair",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              {
                _date = _dateController.text;
                _serviceName = txt.text;
                await repairDatabaseHelper.insertCarNote(
                  RepairDomain(
                    _serviceName,
                    _mileage,
                    _date,
                    _partsCost,
                    _labourCost,
                    _totalCost,
                    _vendorCodes,
                    _comment,
                  ),
                );
                Navigator.pop(context);
              }
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
                child: Image.asset(serviceImages[serviceNumber]),
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
                      _isClickedServiceName == true ? "Enter service name" : "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: TextField(
                        controller: finding < 0 ? null : (txt),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _serviceName = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _isClickedServiceName = true;
                            _isClickedMileage = false;
                            _isClickedParts = false;
                            _isClickedTotal = false;
                            _isClickedLabour = false;
                            _isClickedComment = false;
                            _isClickedVendorCodes = false;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            _isClickedServiceName == true
                                ? Icons.settings
                                : null,
                            color: Colors.white,
                          ),
                          hintText: _isClickedServiceName == false
                              ? "Enter service name"
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
                        onTap: () {
                          setState(() {
                            _isClickedServiceName = false;
                            _isClickedMileage = true;
                            _isClickedLabour = false;
                            _isClickedTotal = false;
                            _isClickedParts = false;
                            _isClickedVendorCodes = false;
                            _isClickedComment = false;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _mileage = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: _isClickedMileage == false ? "Mileage" : "",
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
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Costs",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                            _isClickedParts == true ? "Parts" : "",
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
                                  _isClickedServiceName = false;
                                  _isClickedMileage = false;
                                  _isClickedParts = true;
                                  _isClickedTotal = false;
                                  _isClickedLabour = false;
                                  _isClickedComment = false;
                                  _isClickedVendorCodes = false;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _partsCost = double.parse(value);
                                });
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  _isClickedParts == true
                                      ? Icons.currency_pound
                                      : null,
                                  color: Colors.white,
                                ),
                                hintText:
                                    _isClickedParts == false ? "Parts" : "",
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
                            _isClickedLabour == true ? "Labour" : "",
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
                                  _isClickedServiceName = false;
                                  _isClickedMileage = false;
                                  _isClickedParts = false;
                                  _isClickedLabour = true;
                                  _isClickedTotal = false;
                                  _isClickedVendorCodes = false;
                                  _isClickedComment = false;
                                });
                              },
                              onChanged: (value) {
                                _labourCost = double.parse(value);
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  _isClickedLabour == true
                                      ? Icons.currency_pound
                                      : null,
                                  color: Colors.white,
                                ),
                                hintText:
                                    _isClickedLabour == false ? "Labour" : "",
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
                            _isClickedTotal == true ? "Total" : "",
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
                                  _isClickedServiceName = false;
                                  _isClickedMileage = false;
                                  _isClickedParts = false;
                                  _isClickedLabour = false;
                                  _isClickedTotal = true;
                                  _isClickedVendorCodes = false;
                                  _isClickedComment = false;
                                });
                              },
                              onChanged: (value) {
                                _totalCost = double.parse(value);
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  _isClickedTotal == true
                                      ? Icons.currency_pound
                                      : null,
                                  color: Colors.white,
                                ),
                                hintText:
                                    _isClickedTotal == false ? "Total" : "",
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
                      _isClickedVendorCodes == true ? "Vendor codes" : "",
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
                            _isClickedServiceName = false;
                            _isClickedMileage = false;
                            _isClickedParts = false;
                            _isClickedTotal = false;
                            _isClickedLabour = false;
                            _isClickedComment = false;
                            _isClickedVendorCodes = true;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _vendorCodes = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: _isClickedVendorCodes == false
                              ? "Vendor codes"
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
                        onTap: () {
                          setState(() {
                            _isClickedServiceName = false;
                            _isClickedMileage = false;
                            _isClickedParts = false;
                            _isClickedTotal = false;
                            _isClickedLabour = false;
                            _isClickedComment = true;
                            _isClickedVendorCodes = false;
                          });
                        },
                        onChanged: (value) {
                          _comment = value;
                        },
                        decoration: InputDecoration(
                          hintText: _isClickedComment == false ? "Comment" : "",
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
