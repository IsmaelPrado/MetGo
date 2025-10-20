import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metgo/features/home/domain/models/place.dart';

class GoogleMapsService {
  final String apiKey;
  GoogleMapsService(this.apiKey);

  Future<List<Place>> getNearbyMedicalPlaces(double lat, double lng) async {
    final types = [
      'hospital',
      'pharmacy',
      'doctor',
      'dentist',
      'physiotherapist'
    ];

    List<Place> allPlaces = [];

    for (final type in types) {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=$lat,$lng'
        '&radius=3000'
        '&type=$type'
        '&key=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;
        allPlaces.addAll(results.map((p) => Place.fromJson(p)).toList());
      }
    }

    // 🔹 Opcional: eliminar duplicados por place_id o nombre
    final unique = {for (var p in allPlaces) p.placeId: p}.values.toList();
    return unique;
  }
}

