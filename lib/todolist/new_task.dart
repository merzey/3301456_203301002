import 'package:flutter/material.dart';
import 'package:butunlemeodev/database/db.dart';
import 'package:butunlemeodev/models/todomodel.dart';
import 'package:butunlemeodev/todolist/todo.dart';
import 'package:butunlemeodev/utils/utils.dart';
import 'package:sqflite/sqflite.dart';


var globalDate = "Pick Date";

class new_task extends StatefulWidget {
  final String appBarTitle;
  late Task task;
  todo_state todoState;
  new_task(this.task, this.appBarTitle, this.todoState);


  @override
  State<StatefulWidget> createState() {
    return task_state(task, appBarTitle, todoState);
  }
}

class task_state extends State<new_task> {


  todo_state todoState;
  String appBarTitle;
  Task task;
  late List<Widget> icons;
  task_state(
      this.task,
      this.appBarTitle,
      this.todoState);

  bool marked = false;

  TextStyle titleStyle =  const TextStyle(
    fontSize: 18,
    fontFamily: "Nunito",
  );

  TextStyle buttonStyle =
   const TextStyle(fontSize: 18, fontFamily: "Nunito", color: Colors.white);

  final scaffoldkey = GlobalKey<ScaffoldState>();

  DatabaseHelper helper = DatabaseHelper();
  Utils utility =  Utils();
  TextEditingController taskController =  TextEditingController();


  var formattedDate = "Tarih Belirle";
  var formattedTime = "Select Time";
  final _minPadding = 10.0;
  late DateTime selectedDate;
  late TimeOfDay selectedTime ;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    taskController.text = task.task;
    return Form(
      key: _formKey,
      child: Scaffold(
          key: scaffoldkey,
          appBar: AppBar(backgroundColor: Colors.green[300],
            leading:  GestureDetector(
              child: const Icon(Icons.close, size: 30),
              onTap: () {
                Navigator.pop(context);
                todoState.updateListView();
              },
            ),
            title: Text(appBarTitle, style: const TextStyle(fontSize: 25)),
          ),
          body: ListView(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: _isEditable() ?  CheckboxListTile(
                    title: Text("Yapıldı!", style: titleStyle),
                    value: marked,
                    onChanged: (bool ?value) {
                      setState(() {
                        marked = value!;
                      });
                    }
                )//CheckboxListTile
                    : Container(height: 2,)
            ),


            Padding(
              padding: EdgeInsets.all(_minPadding),
              child: TextField(
                controller: taskController,
                decoration: const InputDecoration(
                    labelText: "Görev",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                    ),
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: "Nunito",
                        fontStyle: FontStyle.italic,
                        color: Colors.grey)), //Input Decoration
                onChanged: (value) {
                  updateTask();
                },
              ), //TextField
            ), //Padding

            ListTile(
              title: task.date.isEmpty
                  ? Text(
                "Tarih Seçiniz:",
                style: titleStyle,
              )
                  : Text(task.date),
              subtitle: const Text(""),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                var pickedDate = await utility.selectDate(context, task.date);
                if (pickedDate.isNotEmpty) {
                  setState(() {
                    formattedDate = pickedDate;
                    task.date = formattedDate;
                  });
                }
              },

            ), //DateListTile

            ListTile(
              title: task.time.isEmpty
                  ? Text(
                "Saat Seçiniz:",
                style: titleStyle,
              )
                  : Text(task.time),
              subtitle:  Text(""),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                var pickedTime = await utility.selectTime(context);
                if (pickedTime.isNotEmpty) {
                  setState(() {
                    formattedTime = pickedTime;
                    task.time = formattedTime;
                  });
                }
              },
            ), //TimeListTile

            Padding(
              padding: EdgeInsets.all(_minPadding),
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                onPrimary: Color(0xff81c784),
                elevation: 5.0,
              ),


                child: Text(
                  "Kaydet",
                  style: buttonStyle,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                ),
                onPressed: () {
                  setState(() {
                    _save();
                  });
                },
              ), //RaisedButton
            ), //Padding

            Padding(
              padding: EdgeInsets.all(_minPadding),
              child: _isEditable()
                  ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 5.0,
                child: Text(
                  "Sil",
                  style: buttonStyle,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                ),
                onPressed: () {
                  setState(() {
                    _delete();
                  });
                },
              ) //RaisedButton
                  : Container(),
            ) //Padding
          ]) //ListView

      ),
    ); //Scaffold
  } //build()

  void markedDone() {

  }

  bool _isEditable() {
    if (appBarTitle == "Görev Ekleyin") {
      return false;
    } else {
      return true;
    }
  }

  void updateTask() {
    task.task = taskController.text;
  }

  //InputConstraints
  bool _checkNotNull() {
    bool res;
    if (taskController.text.isEmpty) {
      utility.showSnackBar(scaffoldkey, 'Boş bir not ekleyemezsiniz!');
      res = false;
    } else if (task.date.isEmpty) {
      utility.showSnackBar(scaffoldkey, 'Lütfen tarih belirtin!');
      res = false;
    } else if (task.time.isEmpty) {
      utility.showSnackBar(scaffoldkey, 'Lütfen saati belirtin!');
      res = false;
    } else {
      res = true;
    }
    return res;
  }

  //Save data
  void _save() async {
    int result;
    if(_isEditable()) {
      task.task = taskController.text;
      task.date = formattedDate;
      task.status = "Not edildi!;)";
      getDatabasesPath();
      if (marked) {
        task.task = taskController.text;
        task.date = formattedDate;
        task.status = "Tamamlandı!;)";
        getDatabasesPath();
      }
      else {
        task.status = "";
      }

    }



    if (_checkNotNull() == true) {
      if (task.id != null) {
        //Update Operation
        result = await helper.updateTask(task);
      } else {
        //Insert Operation
        result = await helper.insertTask(task);
      }

      todoState.updateListView();

      Navigator.pop(context);

      if (result != 0) {
        utility.showAlertDialog(context, 'Status', 'Başarıyla not edildi.');
        getDatabasesPath();
      } else {
        utility.showAlertDialog(context, 'Status', 'Not kaydedilirken bir hata oluştu');
      }
    }
  } //_save()

  void _delete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Bu notu silmek istediğine emin misin?"),
            actions: <Widget>[
              RawMaterialButton(
                onPressed: () async {
                  await helper.deleteTask(task.id!);
                  todoState.updateListView();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  utility.showSnackBar(
                      scaffoldkey, 'Not Başarıyla Silindi.');
                },
                child: const Text("Evet"),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Hayır"),
              )
            ],
          );
        });
  }
}