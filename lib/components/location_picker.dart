import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationPicker extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  final double height;

  LocationPicker({
    required this.onLocationSelected,
    this.height = 500,
  });

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? _controller;
  LatLng? _initialPosition;
  LatLng? _selectedPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      // Usar una ubicación por defecto si no se puede obtener la ubicación actual
      _initialPosition = const LatLng(0, 0);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onMapTap(LatLng position) async {
    setState(() {
      _selectedPosition = position;
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('selected-location'),
        position: position,
      ));
    });

    if (_controller != null) {
      await _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 15, // Cambia el nivel de zoom según sea necesario
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Stack(
        children: [
          if (_initialPosition != null)
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition!,
                zoom: 15.0,
              ),
              onTap: _onMapTap,
              markers: _markers,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
            )
          else
            const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_selectedPosition != null) {
                  widget.onLocationSelected(_selectedPosition!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor selecciona una ubicación en el mapa.'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('Seleccionar'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
