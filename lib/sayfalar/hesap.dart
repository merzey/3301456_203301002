
import 'package:butunlemeodev/sayfalar/yap%C4%B1lacaklar.dart';
import 'package:flutter/material.dart';
import 'havadurumu.dart';

class Hesap extends StatefulWidget {
  const Hesap({Key? key}) : super(key: key);

  @override
  State<Hesap> createState() => _HesapState();
}

class _HesapState extends State<Hesap> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.blueGrey[900],
            child: Center(
              child: SingleChildScrollView(

                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //AuthPage(),
                    const SizedBox(height: 30.0,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Expanded(
                        child: Container(
                            margin: EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: const [
                            Image(image: AssetImage('assets/images/bcg5.jpg')),
                            Text('Günlük Yapılacaklar',style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),)
                          ],)
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Weather()));

                      },
                      child: Expanded(
                        child: Container(
                          margin: EdgeInsets.all(8.0),

                          child: Stack(alignment: Alignment.center,
                            children: const [
                            Image(image: AssetImage('assets/images/bcg5.jpg')),
                            Text('Hava Durumu',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                              fontSize: 25.0),)
                          ],),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
