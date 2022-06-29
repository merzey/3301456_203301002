import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const.dart';
import '../models/weather_model.dart';
import '../services/data_services.dart';


class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse? _response;

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bcg3.jpg"), fit: BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: d
                          ),
                        ),
                        height: 300,
                        width: 400,
                        margin: EdgeInsets.all(20),
                      ),
                      Positioned(
                        bottom:95,
                        left:100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_response != null)
                              Column(children: [
                                Image.network(_response!.iconUrl,
                                  scale:0.30,
                                ),
                              ]),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 40,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: SizedBox(
                                width: 105,
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                  controller: _cityTextController,
                                  decoration:
                                  InputDecoration(labelText: 'Bir şehir gir.',
                                      labelStyle: TextStyle(
                                          color: d
                                      ),
                                      fillColor: d),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 40,
                        child: Container(
                          decoration:BoxDecoration (
                              color: c,
                              borderRadius: BorderRadius.circular(35)
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton.icon(
                                onPressed: _search,
                                icon: Icon(Icons.search, size: 20, color: d,),
                                label: Text("Hava durumunu gör.",
                                  style: TextStyle(color: d,
                                      fontSize: 16),),
                              )
                          ),
                        ),
                      ),

                      Positioned(
                        top:50,
                        left: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_response != null)
                              Column(children: [
                                Text(
                                  '${_response?.tempInfo?.temperature}'+' C°',
                                  style: GoogleFonts.staatliches(
                                    textStyle: TextStyle(color: d, fontSize: 50),
                                  ),
                                ),
                              ]),
                          ],

                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_response != null)
                              Text(
                                '${_response?.weatherInfo?.description}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}