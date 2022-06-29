import 'package:butunlemeodev/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:butunlemeodev/todolist/new_task.dart';
import 'dart:async';
import 'package:butunlemeodev/models/todomodel.dart';
import 'package:butunlemeodev/database/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:butunlemeodev/todolist/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class todo extends StatefulWidget {
  final dynamic darkThemeEnabled;
  todo(this.darkThemeEnabled);

  @override
  State<StatefulWidget> createState() {
    return todo_state();
  }
}

class todo_state extends State<todo> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Utils utility = Utils();
  late List<Task> taskList;
  int count = 0;
  late String _themeType;
  final homeScaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (!widget.darkThemeEnabled) {
      _themeType = 'Light Theme';
    } else {
      _themeType = 'Dark Theme';
    }
    super.initState();
  }

  _setPref(bool res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkTheme', res);
  }

  @override
  Widget build(BuildContext context) {
    taskList = <Task>[];
    updateListView();

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          key: homeScaffold,
          appBar: AppBar(backgroundColor: Color(0xff81c784),
            title: const Text(
              'Yapılacaklar Listen ',
              style: TextStyle(fontSize: 25),
              
            ),
            actions: <Widget>[
              PopupMenuButton<bool>(
                onSelected: (res) {
                  bloc.changeTheme(res);
                  _setPref(res);
                  setState(() {
                    if (_themeType == 'Dark Theme') {
                      _themeType = 'Light Theme';
                    } else {
                      _themeType = 'Dark Theme';
                    }
                  });
                },
                itemBuilder: (context) {
                  return <PopupMenuEntry<bool>>[
                    PopupMenuItem<bool>(
                      value: !widget.darkThemeEnabled,
                      child: Text(_themeType),
                    )
                  ];
                },
              )
            ],
            bottom: const TabBar(
                
                tabs: [
              Tab(
                icon: Icon(Icons.format_list_numbered_rtl),
              ),
              Tab(
                icon: Icon(Icons.playlist_add_check),
              )
            ]),
          ), //AppBar
          body: TabBarView(children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: databaseHelper.getInCompleteTaskList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Text("Yükleniyor...");
                        } else {
                          if (snapshot.data.length < 1) {
                            return const Center(
                              child: Text(
                                'Henüz bir görev eklemediniz...',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return GestureDetector(
                                    onTap: () {
                                      if (snapshot.data[position].status !=
                                          "Görev Tammalandı! :)") {
                                        navigateToTask(snapshot.data[position],
                                            "Notunuzu düzenleyin", this);
                                      }
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(1.0),
                                      elevation: 2.0,
                                      child: CustomWidget(
                                        title: snapshot.data[position].task,
                                        sub1: snapshot.data[position].date,
                                        sub2: snapshot.data[position].time,
                                        status: snapshot.data[position].status,
                                        delete:
                                            snapshot.data[position].status ==
                                                    "Görev Tamamlandı"
                                                ? const IconButton(
                                                    icon: Icon(Icons.delete),
                                                    onPressed: null,
                                                  )
                                                : Container(),
                                        trailing: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                          size: 28,
                                        ), //key: null,
                                      ),
                                    ) //Card
                                    );
                              });
                        }
                      },
                    ),
                  )
                ],
              ),
            ), //Container
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: databaseHelper.getCompleteTaskList(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Text("Yükleniyor");
                        } else {
                          if (snapshot.data.length < 1) {
                            return const Center(
                              child: Text(
                                'Tamamlanan görev yok :(',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }
                          return ListView.builder(

                             itemCount: snapshot.data.length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return GestureDetector(

                                    onTap: () {
                                      getDatabasesPath();
                                      if (snapshot.data[position].status !=
                                          "Yapıldı") {
                                        navigateToTask(snapshot.data[position],
                                            "Düzenle", this);
                                        getDatabasesPath();
                                      }
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(1.0),
                                      elevation: 2.0,
                                      child: CustomWidget(
                                          title: snapshot.data[position].task,
                                          sub1: snapshot.data[position].date,
                                          sub2: snapshot.data[position].time,
                                          status:
                                              snapshot.data[position].status,
                                          delete: snapshot
                                                      .data[position].status ==
                                                  "Görev Tamamlandı! :)"
                                              ? IconButton(
                                                  icon: Icon(Icons.delete,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: 28),
                                                  onPressed: () {
                                                    delete(snapshot
                                                        .data[position].id);
                                                  },
                                                )
                                              : Container(),
                                          trailing: Container()
//                                    Icon(
//                                          Icons.edit,
//                                          color: Theme.of(context).primaryColor,
//                                          size: 28,
//                                        ),
                                          ),
                                    ) //Card
                                    );
                              });
                        }
                      },
                    ),
                  )
                ],
              ),
            ), //Container
          ]),
          floatingActionButton: FloatingActionButton(backgroundColor: Color(0xff81c784),
              tooltip: "Not Ekle",
              child: const Icon(Icons.add),
              onPressed: () {
                navigateToTask(Task('', '', '', ''), "Bir görev ekleyin", this);
              }), //FloatingActionButton
        ));
  } //build()

  void navigateToTask(Task task, String title, todo_state obj) async {
    dynamic result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new_task(task, title, obj)),
    );
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        setState(() {
          taskList = taskList;
          count = taskList.length;
        });
      });
    });
  } //updateListView()

  void delete(int id) async {
    await databaseHelper.deleteTask(id);
    updateListView();
    Navigator.pop(context);
    utility.showSnackBar(homeScaffold, 'Not başarıyla silindi...');
  }
}
