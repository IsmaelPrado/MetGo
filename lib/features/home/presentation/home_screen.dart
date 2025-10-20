import 'package:flutter/material.dart';
import 'package:metgo/features/home/data/services/google_maps_service.dart';
import 'package:metgo/features/home/presentation/controllers/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController(GoogleMapsService('AIzaSyDjBOcG64NMz6zzn2hdlZmxCzL1GRDJnBw'))
      ..init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>.value(
      value: controller,
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Error: ${controller.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (controller.currentLocation == null) {
            return const Scaffold(
              body: Center(child: Text('No se pudo obtener ubicación')),
            );
          }

          return Scaffold(
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation!,
                zoom: 14,
              ),
              markers: controller.markers,
              myLocationEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController mapController) {
                debugPrint('Mapa creado correctamente');
              },
            ),
          );
        },
      ),
    );
  }
}
