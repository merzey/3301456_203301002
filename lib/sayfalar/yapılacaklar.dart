import 'dart:async';

import 'package:flutter/material.dart';
import 'package:butunlemeodev/utils/theme.dart';
import 'package:butunlemeodev/todolist/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:butunlemeodev/todolist//theme_data.dart';


final routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget{

  _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? val = prefs.getBool('darkTheme');
    val ??= true;
    return val;
  }





  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTheme(),
      builder: (context, snapshot)    {
        final initialdd=snapshot.data;
        assert(snapshot != null);
        if (initialdd== null) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Loading"),
              ),
            ),
          );
        } else {
          return todo(snapshot.data);
        }
      },
    );
  }
}