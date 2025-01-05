  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../controllers/maps_controller.dart';

  class MapsView extends GetView<MapsController> {
    const MapsView({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('MapsView'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.getCurrentLocation,  // Call the controller's method to get location
            ),
          ],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Titik Koordinat',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() {
                return Text(controller.locationMessage.value); // Use the reactive variable
              }),
              const SizedBox(height: 20),
              Obx(() {
                return controller.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: controller.getCurrentLocation,  // Call the controller's method to get location
                  child: const Text('Cari Lokasi'),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.openGoogleMaps,  // Call the controller's method to open Google Maps
                child: const Text('Buka Google Maps'),
              ),
            ],
          ),
        ),
      );
    }
  }
