import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pfe_coashing_app/models/gym.dart';

class GymsService {
  final Dio _dio = Dio();
  final String baseUrl = Platform.isAndroid 
      ? 'http://10.0.2.2:1337/api'
      : 'http://localhost:1337/api';

  Future<List<Gym>> fetchGyms() async {
    try {
      final response = await _dio.get("$baseUrl/gyms");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final List<dynamic> gymsData = jsonResponse['data'];

        return gymsData.map((gym) {
          final address = gym['address'];
          return Gym(
            id: gym['id'],
            documentId: gym['documentId'],
            name: gym['name'] ?? '',
            // Use address if available, otherwise default to 0,0
            lat: address?['lat']?.toDouble() ?? 0.0,
            long: address?['long']?.toDouble() ?? 0.0,
            description: 'ID: ${gym['documentId']}',
          );
        }).toList();
      } else {
        throw Exception('Failed to load gyms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching complexes: $e');
      return [];
    }
  }
  

}