import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class WeatherService {
  // static Future<Map<String, dynamic>?> fetchWeather(String city) async {
  //   try {
  //     final url =
  //         'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return {
  //         'temp': data['main']['temp'],
  //         'description': data['weather'][0]['description'],
  //       };
  //     } else {
  //       print('Failed to fetch weather data');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }

  static Future<Map<String, dynamic>?> fetchWeather(String city) async {
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'temp': data['main']['temp'],
          'description': data['weather'][0]['description'],
        };
      } else {
        print('Failed to fetch weather data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

}
