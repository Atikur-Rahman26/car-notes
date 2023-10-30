class RefuelinDomain {
  late final int _id;
  late final String _fuelType;
  late final double _fuelTotalCost;
  late final double _pricePerLiter;
  late final double _fuelVolume;
  late final int _fullTank;
  late final int _mileage;
  late final String _date;
  late final String _time;
  late final String _comment;

  RefuelinDomain(
    this._fuelType,
    this._fuelTotalCost,
    this._pricePerLiter,
    this._fuelVolume,
    this._fullTank,
    this._mileage,
    this._date,
    this._time,
    this._comment,
  );
  RefuelinDomain.withID(
    this._id,
    this._fuelType,
    this._fuelTotalCost,
    this._pricePerLiter,
    this._fuelVolume,
    this._fullTank,
    this._mileage,
    this._date,
    this._time,
    this._comment,
  );

  String get fuelType => _fuelType;

  int get id => _id;

  double get fuelTotalCost => _fuelTotalCost;

  String get comment => _comment;

  String get time => _time;

  String get date => _date;

  int get mileage => _mileage;

  int get fullTank => _fullTank;

  double get fuelVolume => _fuelVolume;

  double get pricePerLiter => _pricePerLiter;

  set id(int value) {
    _id = value;
  }

  set fuelType(String value) {
    _fuelType = value;
  }

  set fuelTotalCost(double value) {
    _fuelTotalCost = value;
  }

  set pricePerLiter(double value) {
    _pricePerLiter = value;
  }

  set fuelVolume(double value) {
    _fuelVolume = value;
  }

  set fullTank(int value) {
    _fullTank = value;
  }

  set mileage(int value) {
    _mileage = value;
  }

  set date(String value) {
    _date = value;
  }

  set time(String value) {
    _time = value;
  }

  set comment(String value) {
    _comment = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['fuel_type'] = _fuelType;
    map['fuel_total_Cost'] = _fuelTotalCost;
    map['price_per_liter'] = _pricePerLiter;
    map['fuel_volume'] = _fuelVolume;
    map['full_tank'] = _fullTank;
    map['mileage'] = _mileage;
    map['date'] = _date;
    map['time'] = _time;
    map['comment'] = _comment;

    return map;
  }

  RefuelinDomain.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fuelType = map['fuel_type'];
    this._fuelTotalCost = map['fuel_total_cost'];
    this._pricePerLiter = map['price_per_liter'];
    this._fuelVolume = map['fuel_volume'];
    this._fullTank = map['full_tank'];
    this._mileage = map['mileage'];
    this._date = map['date'];
    this._time = map['time'];
    this._comment = map['comment'];
  }
}
