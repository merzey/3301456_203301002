import 'dart:core';



class Task {
 int ?_id;
 late String _task;
  late String _date;
 late String _time;
 late String _status;

  Task(this._task, this._date, this._time, this._status);
  Task.withId(this._id, this._task, this._date, this._time, this._status);

  int? get id => _id;
  String get task => _task;
  String get date => _date;
  String get time => _time;
  String get status => _status;

  set task(String newTask) {
    if (newTask.length <= 255) {
      _task = newTask;
    }
  }

  set date(String newDate) => _date = newDate;

  set time(String newTime) => _time = newTime;

  set status(String newStatus) => _status = newStatus;

  //Convert Task object into MAP object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['task'] = _task;
    map['date'] = _date;
    map['time'] = _time;
    map['status'] = _status;
    return map;
  }

  //Extract Task object from MAP object
  Task.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _task = map['task'];
    _date = map['date'];
    _time = map['time'];
    _status = map['status'];
  }
}
