import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends StatelessWidget {
  LatLng mandirLatLng = LatLng(27.5886, 82.2181);
  LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mandir Location"),
      ),
      body: Expanded(
          child: FlutterMap(
              options: MapOptions(
                initialZoom: 10.0,
                initialCenter: mandirLatLng,
              ),
              children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(markers: [
              Marker(
                  point: mandirLatLng,
                  child: const Icon(
                    Icons.temple_hindu,
                    size: 70,
                  )),
            ])
          ])),
    );
  }
}
