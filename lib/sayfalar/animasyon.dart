import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math' as math;
//import 'package:butunlemeodev/main.dart';
//import 'saat.dart';


class Animasyon extends StatefulWidget {
  final int onTime;
  final Duration timerDuration;
  final int limit;
  final int start;
  final bool showHour;
  final String? ampm;

  const Animasyon(
      { required this.onTime,
      required this.timerDuration,
      required this.limit,
      required this.start,
      required this.showHour,
      required this.ampm});

  @override
  State<Animasyon> createState() => _AnimasyonState();
}

class _AnimasyonState extends State<Animasyon>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    //var _start = widget.onTime;
    _start=widget.onTime;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween<double>(end: math.pi, begin: math.pi * 2)
        .animate(_animationController!) ;

    _animation.addListener(() {
     // _animation as Listenable;
      setState(() {});
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 99.0,
                    width: 200.0,
                    decoration: _boxDecoration(true),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: Platform.isAndroid ? 15 : 5.0,
                            child: _timeText()),
                        widget.showHour
                            ? Positioned(
                                top: 10.0,
                                left: 10.0,
                                child: Text(
                                  widget.ampm ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                            : SizedBox.shrink()
                      ],
                    )),
                Divider(
                  height: 2.0,
                  color: Colors.black,
                ),
                Stack(children: [
                  Container(
                      height: 99,
                      width: 200,
                      decoration: _boxDecoration(false),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                              bottom: Platform.isAndroid ? 23 : 15.0,
                              child: _timeText())
                        ],
                      )),
                  AnimatedBuilder (
                      animation: _animation,
                      child: Container(
                          height: 100.0,
                          width: 200.0,
                          decoration: _boxDecoration(false),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _animation.value > 4.71
                                  ? Positioned(
                                      bottom: Platform.isAndroid ? 23 : 15.0,
                                      child: _timeText())
                                  : Positioned(
                                      top: Platform.isAndroid ? 87 : 98.0,
                                      child: Transform(
                                          transform: Matrix4.rotationX(math.pi),
                                          child: _timeText()))
                            ],
                          )),
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.003)
                            ..rotateX(_animation.value),
                          child: child,
                        );
                      })
                ]),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 99),
                child: Container(
                  color: Colors.black,
                  height: 2.0,
                  width: 200.0,
                ))
          ],
        ));
  }

  BoxDecoration _boxDecoration(bool top) => BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(top ? 10 : 0),
          topRight: Radius.circular(top ? 10 : 0),
          bottomLeft: Radius.circular(top ? 0 : 10),
          bottomRight: Radius.circular(top ? 0 : 10)),
      color: Color.fromRGBO(20, 20, 20, 1));

  Text _timeText() {
    return Text(_start.toString().padLeft(2, '0'),
        style: TextStyle(
            fontFamily: 'Raleway', fontSize: 150.0, color: Colors.white,fontWeight: FontWeight.bold));
  }

  late Timer _timer;
  int _start = 0;

  void startTimer() {
    Duration oneSec = widget.timerDuration;
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start == widget.limit) {
        setState(() {
          _start = widget.start;
        });
      } else {
        _animationController!.reset();
        setState(() {
          _start++;
        });
        _animationController!.forward();
      }
    });
  }

  double angle = 2 * math.pi;

  @override
  void dispose() {
    _timer.cancel();
    _animationController!.dispose();
    super.dispose();
  }
}
