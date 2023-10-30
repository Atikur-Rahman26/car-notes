import 'package:car_notes/data/papers_database.dart';
import 'package:car_notes/domain/papers_domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPapersScreen extends StatefulWidget {
  static const id = 'AddPapersScreen';
  static bool editing = false;
  const AddPapersScreen({super.key});

  @override
  State<AddPapersScreen> createState() => _AddPapersScreenState();
}

class _AddPapersScreenState extends State<AddPapersScreen> {
  bool _isClickedDocumentName = false;
  bool _isClickedMileage = false;
  bool _isClickedTotalCost = false;
  bool _isClickedComment = false;
  static int serviceNumber = 0;
  static int finding = 0;
  String _documentName = "";
  int _mileage = -2;
  String _date = "";
  double _totalCost = -2;
  String _comment = "";
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
  PapersDatabaseHelper _papersDatabaseHelper = PapersDatabaseHelper();
  final EdgeInsets _containerPadding = const EdgeInsets.only(
    top: 10,
    left: 10,
    right: 10,
    bottom: 5,
  );
  final EdgeInsets _containerMargin = const EdgeInsets.only(
    top: 10,
    left: 10,
    right: 10,
    bottom: 5,
  );
  var txt = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _mileageController = TextEditingController();
  TextEditingController _totalCostController = TextEditingController();
  TextEditingController _commnetController = TextEditingController();
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showBottomSheet();
    });
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
          title: const Text(
            "Add document",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  _date = _dateController.text;
                  _documentName = txt.text;
                  if (_mileage == -2 ||
                      _documentName == "" ||
                      _date == "" ||
                      _totalCost == -2 ||
                      _comment == "") {
                  } else {
                    await _papersDatabaseHelper.insertPaper(PapersDomain(
                        _documentName, _mileage, _date, _totalCost, _comment));
                    Navigator.pop(context);
                  }
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
                  margin: _containerMargin,
                  padding: _containerPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedDocumentName == true
                            ? "Enter document name"
                            : "",
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
                          onTap: () {
                            setState(() {
                              _isClickedDocumentName = true;
                              _isClickedComment = false;
                              _isClickedMileage = false;
                              _isClickedTotalCost = false;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _documentName = value;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              _isClickedDocumentName == true
                                  ? Icons.insert_page_break
                                  : null,
                              color: Colors.white,
                            ),
                            hintText: _isClickedDocumentName == false
                                ? "Enter document name"
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
                  margin: _containerMargin,
                  padding: _containerPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedMileage == true ? "Mileage" : "",
                        style: const TextStyle(color: Colors.white),
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
                              _isClickedDocumentName = false;
                              _isClickedComment = false;
                              _isClickedMileage = true;
                              _isClickedTotalCost = false;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _mileage = int.parse(value);
                            });
                          },
                          decoration: InputDecoration(
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
                  margin: _containerMargin,
                  padding: _containerPadding,
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
                  margin: _containerMargin,
                  padding: _containerPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedTotalCost == true ? "Total cost" : "",
                        style: const TextStyle(color: Colors.white),
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
                              _isClickedDocumentName = false;
                              _isClickedComment = false;
                              _isClickedMileage = false;
                              _isClickedTotalCost = true;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _totalCost = double.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.currency_exchange_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            hintText: _isClickedTotalCost == false
                                ? "Total cost"
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
                  margin: _containerMargin,
                  padding: _containerPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _isClickedComment == true ? "Comment" : "",
                        style: const TextStyle(color: Colors.white),
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
                              _isClickedDocumentName = false;
                              _isClickedComment = true;
                              _isClickedMileage = false;
                              _isClickedTotalCost = false;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _comment = value;
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

  List<Widget> bottomSheet({
    required List<String> serviceNames,
    required List<String> serviceImages,
  }) {
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
