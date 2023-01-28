import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  MapView({super.key, this.mapController, this.showMyLocation = true, this.location});

  MapController? mapController;
  bool showMyLocation;
  LatLng? location;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  initState() {
    super.initState();
    widget.mapController ??= MapController();
    if(widget.showMyLocation) {
      _determinePosition().then((value) =>
          widget.mapController?.move(
              LatLng(value.latitude, value.longitude), 16));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
        center: widget.location ?? LatLng(36.569537, 137.383705),
        zoom: 16,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
        FloatingActionButton(
            heroTag: "myLocation",
            mini: true,
            child: const Icon(Icons.my_location),
            onPressed: () {
              _determinePosition().then((value) => widget.mapController?.move(
                  LatLng(value.latitude, value.longitude), 16));
            })
      ],
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'org.code4sake.king_of_omi',
        ),
      ],
    ));
  }
}
