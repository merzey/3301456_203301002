import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async{
    final queryParameters = {
      'q': city,
      'appid': '155b52c19f2992cf341af0f3953c77f1',
      'units': 'metric'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final response = await http.get(uri);
    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}