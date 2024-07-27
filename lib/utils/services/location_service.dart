import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> init() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Podrías mostrar un diálogo o mensaje para indicar que los servicios de ubicación no están habilitados
      return null;
    }

    // Verifica el estado del permiso
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permiso denegado, podrías mostrar un mensaje
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permiso denegado para siempre, podrías mostrar un mensaje
      return null;
    }

    // Permisos concedidos, obtiene la ubicación actual
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
