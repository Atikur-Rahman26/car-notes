class RepairDomain {
  late final int _id;
  late final String _serviceName;
  late final double _costsParts;
  late final double _costsLabour;
  late final double _costsTotal;
  late final String _vendorCodes;
  late final int _mileage;
  late final String _date;
  late final String _comment;

  RepairDomain(
    this._serviceName,
    this._mileage,
    this._date,
    this._costsParts,
    this._costsLabour,
    this._costsTotal,
    this._vendorCodes,
    this._comment,
  );
  RepairDomain.withID(
    this._id,
    this._serviceName,
    this._mileage,
    this._date,
    this._costsParts,
    this._costsLabour,
    this._costsTotal,
    this._vendorCodes,
    this._comment,
  );

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['service_name'] = _serviceName;
    map['mileage'] = _mileage;
    map['date'] = _date;
    map['total_costs'] = _costsTotal;
    map['labour_costs'] = _costsLabour;
    map['parts_costs'] = _costsParts;
    map['vendor_codes'] = _vendorCodes;

    map['comment'] = _comment;

    return map;
  }

  RepairDomain.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._serviceName = map['service_name'];
    this._mileage = map['mileage'];
    this._date = map['date'];
    this._costsTotal = map['total_costs'];
    this._costsLabour = map['labour_costs'];
    this._costsParts = map['parts_costs'];
    this._vendorCodes = map['vendor_codes'];

    this._comment = map['comment'];
  }

  String get serviceName => _serviceName;

  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get mileage => _mileage;

  set mileage(int value) {
    _mileage = value;
  }

  String get vendorCodes => _vendorCodes;

  set vendorCodes(String value) {
    _vendorCodes = value;
  }

  double get costsTotal => _costsTotal;

  set costsTotal(double value) {
    _costsTotal = value;
  }

  double get costsLabour => _costsLabour;

  set costsLabour(double value) {
    _costsLabour = value;
  }

  double get costsParts => _costsParts;

  set costsParts(double value) {
    _costsParts = value;
  }

  set serviceName(String value) {
    _serviceName = value;
  }
}
