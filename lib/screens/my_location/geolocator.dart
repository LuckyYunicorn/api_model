import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorScreen extends StatefulWidget {
  const GeolocatorScreen({super.key});

  @override
  State<GeolocatorScreen> createState() => _GeolocatorScreenState();
}

class _GeolocatorScreenState extends State<GeolocatorScreen> {
  Position? position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Geolocator")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(height: 20),
            Text("${position ?? "data"}"),
            ElevatedButton(
              onPressed: () async {
                position = await _getLocation(context: context);
                setState(() {});
              },
              child: Text("Find"),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getLocation({required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Turn on location")));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Access denied")));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Access denied forever")));
    }
    return await Geolocator.getCurrentPosition();
  }
}
