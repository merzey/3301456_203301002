import 'package:butunlemeodev/sayfalar/animasyon.dart';
import 'package:flutter/material.dart';
//import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';



Color whiteColor = Color.fromRGBO(186, 186, 186, 1);


class Saat extends StatefulWidget {
  @override
  State<Saat> createState() => _SaatState();
}


class _SaatState extends State<Saat> {
  //datatype
  static DateTime _currentTime = DateTime.now();
  bool _listnerStarted = false;
  int _hour12 = 00;
  String? _meridian;
  bool _chnageHourTo12 = true;


  //fonksiyon

  final Stream _timer = Stream.periodic(Duration(seconds: 1), (i) {
    _currentTime = _currentTime.add(
      Duration(seconds: 1),
    );
    return _currentTime;
  });

  _listenToTime() {
    _timer.listen((event) {
      print(event);
      _currentTime = DateTime.parse(event.Int());
    });
    _listnerStarted=true;
  }

  @override
  Widget build(BuildContext context) {
    _chnageHourTo12
        ? _hour12 = int.parse(DateFormat("h").format(_currentTime).toString())
        : _hour12 = _currentTime.hour.toInt();

    _meridian = DateFormat("a").format(_currentTime).toString();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    !_listnerStarted ? _listenToTime() : print("listener is working");



    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: GestureDetector(
          onDoubleTap: (){
            _chnageHourTo12 == false
                ? _chnageHourTo12 = true
                : _chnageHourTo12 = false;

            SystemChrome.setPreferredOrientations([
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? DeviceOrientation.portraitUp
                  : DeviceOrientation.landscapeLeft,
            ]);
            setState(() {

            });
          },

          child: OrientationBuilder(
              builder: (context,layout){
                if(layout==Orientation.portrait){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Animasyon(
                          onTime: _hour12,
                          timerDuration: Duration(minutes: 60- _currentTime.minute.toInt()),
                          limit: _chnageHourTo12?12:23,
                          start: 00,
                          showHour:_chnageHourTo12 ,
                          ampm: _meridian),
                      Animasyon(
                          onTime: _currentTime.minute.toInt(),
                          timerDuration: Duration(seconds: 60- _currentTime.second.toInt()),
                          limit: 59,
                          start: 00,
                          showHour:false,
                          ampm: null ,

                          )
                    ],
                  );
                }

                else{
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: height/2-110),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Animasyon(
                            onTime: _hour12,
                            timerDuration: Duration(minutes: 60- _currentTime.minute.toInt()),
                            limit: _chnageHourTo12?12:23,
                            start: 00,
                            showHour:_chnageHourTo12 ,
                            ampm: _meridian),
                        Animasyon(
                            onTime: _currentTime.minute.toInt(),
                            timerDuration: Duration(seconds: 60- _currentTime.second.toInt()),
                            limit: 59,
                            start: 00,
                            showHour:false ,
                            ampm: null),
                        Animasyon(
                            onTime: _currentTime.second.toInt(),
                            timerDuration: Duration(seconds:1 ),
                            limit: 59,
                            start: 00,
                            showHour:false ,
                            ampm: null),
                      ],
                  ),
                  );
                }
              }),

        ),
      ),


    );
  }
}
