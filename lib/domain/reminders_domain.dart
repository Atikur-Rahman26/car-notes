class RemindersDomain {
  late final int _id;
  late final String _reminderText;
  late final double _mileageToRemind;
  late final String _date;
  late final String _additionalTextForReminder;

  RemindersDomain(
    this._reminderText,
    this._mileageToRemind,
    this._date,
    this._additionalTextForReminder,
  );
  RemindersDomain.withID(
    this._id,
    this._reminderText,
    this._mileageToRemind,
    this._date,
    this._additionalTextForReminder,
  );

  String get additionalTextForReminder => _additionalTextForReminder;

  set additionalTextForReminder(String value) {
    _additionalTextForReminder = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  double get mileageToRemind => _mileageToRemind;

  set mileageToRemind(double value) {
    _mileageToRemind = value;
  }

  String get reminderText => _reminderText;

  set reminderText(String value) {
    _reminderText = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['reminder_text'] = _reminderText;
    map['mileage_to_remind'] = _mileageToRemind;
    map['date'] = _date;
    map['additional_text_for_reminder'] = _additionalTextForReminder;
    return map;
  }

  RemindersDomain.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._reminderText = map['reminder_text'];
    this._mileageToRemind = map['mileage_to_remind'];
    this._date = map['date'];
    this._additionalTextForReminder = map['additional_text_for_reminder'];
  }
}
