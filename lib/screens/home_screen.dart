import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = 'Islamabad'; // Default city
  String temperature = '--';
  String description = 'Fetching...';
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    final weatherData = await WeatherService.fetchWeather(city);
    if (weatherData != null) {
      setState(() {
        temperature = '${weatherData['temp']}°C';
        description = weatherData['description'];
      });
    } else {
      setState(() {
        temperature = '--';
        description = 'Error fetching weather';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City Input
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (cityController.text.isNotEmpty) {
                      setState(() {
                        city = cityController.text;
                        fetchWeather();
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Weather Display
            Text(
              city,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              temperature,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Refresh Button
            ElevatedButton.icon(
              onPressed: fetchWeather,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh Weather'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
