


import 'package:butunlemeodev/sayfalar/hesap.dart';
import 'package:butunlemeodev/sayfalar/muzik.dart';
import 'package:butunlemeodev/sayfalar/pomodoro.dart';
import 'package:butunlemeodev/sayfalar/saat.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:butunlemeodev/const.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  final navigationKey=GlobalKey<CurvedNavigationBarState>();
  int index=1;


  final screens=[
    Muzik(),
    Anasayfa1(),
    Hesap()
  ];

  @override
  Widget build(BuildContext context) {

    final items=[
      Icon(Icons.music_note_outlined),
      Icon(Icons.home_outlined),
      Icon(Icons.person_outline)
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Flip & Note It',style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }
              ,
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.grey[500],
        key: navigationKey,
        items: items,
        index: index,
        onTap: (index) =>setState(() => this.index=index),
        height: 60,
        color: const Color(0xff37474f),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: screens[index],
    );
  }
}


class Anasayfa1 extends StatefulWidget {
  const Anasayfa1({Key? key}) : super(key: key);

  @override
  State<Anasayfa1> createState() => _Anasayfa1State();
}

class _Anasayfa1State extends State<Anasayfa1> {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          constraints: const BoxConstraints.expand(),
          color: Colors.black,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(alignment: Alignment.center,
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Saat()));
                      },
                      child: Stack(alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/tissot-g3a60e13b6_1280.jpg'),
                          Center(
                            child: Text(
                              'SAAT',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50.0,
                                  letterSpacing: 2.0),
                            ),
                          )
                        ],
                      )),
                  Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Pomodoro()));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/time-gc722ceeed_1280.jpg'),
                          Text(
                            'POMODORO',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0,

                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
