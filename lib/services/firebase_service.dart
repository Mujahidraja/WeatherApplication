import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> saveWeatherData(String city, double temp, String description) async {
    await _firestore.collection('weather').doc(city).set({
      'temperature': temp,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<Map<String, dynamic>?> getWeatherData(String city) async {
    final doc = await _firestore.collection('weather').doc(city).get();
    if (doc.exists) {
      return doc.data();
    } else {
      print('No data found for city: $city');
      return null;
    }
  }
}
