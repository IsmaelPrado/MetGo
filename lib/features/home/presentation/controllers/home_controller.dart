import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metgo/features/home/data/services/google_maps_service.dart';
import 'package:metgo/features/home/domain/models/place.dart';

class HomeController extends ChangeNotifier {
  final GoogleMapsService mapsService;
  LatLng? currentLocation;
  List<Place> places = [];
  Set<Marker> markers = {};
  String? errorMessage;
  bool loading = true;

  // 🔹 Iconos personalizados por tipo
  late Map<String, BitmapDescriptor> customIcons;

  HomeController(this.mapsService);

  Future<void> init() async {
    try {
      await _loadCustomIcons();
      await _getCurrentLocation();
      await fetchPlaces();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // 🔹 Carga los íconos personalizados desde assets
  Future<void> _loadCustomIcons() async {
    customIcons = {
      'hospital': await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/icons/hospital.png',
      ),
      'pharmacy': await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/icons/pharmacy.png',
      ),
      'doctor': await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/icons/hospital.png',
      ),
      'dentist': await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/icons/hospital.png',
      ),
      'physiotherapist': await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/icons/hospital.png',
      ),
    };
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Por favor activa tu GPS');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permiso de ubicación denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permiso de ubicación denegado permanentemente');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLocation = LatLng(position.latitude, position.longitude);
  }

  Future<void> fetchPlaces() async {
    if (currentLocation == null) return;

    places = await mapsService.getNearbyMedicalPlaces(
      currentLocation!.latitude,
      currentLocation!.longitude,
    );

    markers = places.map((place) {
      final icon = _getIconForType(place.type);
      return Marker(
        markerId: MarkerId(place.placeId),
        position: LatLng(place.lat, place.lng),
        icon: icon,
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.address ?? 'Sin dirección',
        ),
      );
    }).toSet();

    // 🔹 Agregar marcador de tu ubicación actual
    markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'Tú estás aquí'),
      ),
    );

    notifyListeners();
  }

  // 🔹 Devuelve el ícono adecuado según el tipo
  BitmapDescriptor _getIconForType(String? type) {
    if (type == null) return BitmapDescriptor.defaultMarker;
    return customIcons[type] ?? BitmapDescriptor.defaultMarker;
  }
}
