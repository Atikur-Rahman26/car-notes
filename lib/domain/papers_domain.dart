class PapersDomain {
  late final int _id;
  late final String _documentName;
  late final int _mileage;
  late final String _date;
  late final double _totalCost;
  late final String _comment;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  PapersDomain(
    this._documentName,
    this._mileage,
    this._date,
    this._totalCost,
    this._comment,
  );

  PapersDomain.withId(
    this._id,
    this._documentName,
    this._mileage,
    this._date,
    this._totalCost,
    this._comment,
  );

  String get documentName => _documentName;

  set documentName(String value) {
    _documentName = value;
  }

  int get mileage => _mileage;

  set mileage(int value) {
    _mileage = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  double get totalCost => _totalCost;

  set totalCost(double value) {
    _totalCost = value;
  }

  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['document_name'] = _documentName;
    map['mileage'] = _mileage;
    map['date'] = _date;
    map['total_cost'] = _totalCost;
    map['comment'] = _comment;
    return map;
  }

  PapersDomain.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._documentName = map['document_name'];
    this._mileage = map['mileage'];
    this._date = map['date'];
    this._totalCost = map['total_cost'];
    this._comment = map['comment'];
  }
}
