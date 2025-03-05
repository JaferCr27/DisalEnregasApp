import 'package:geolocator/geolocator.dart';

class LocationHelper{
  /// Método para obtener la ubicación actual del usuario
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //print("El servicio de ubicación está deshabilitado.");
      return null;
    }

    // Verificar permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //print("Los permisos de ubicación fueron denegados.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //print("Los permisos están permanentemente denegados.");
      return null;
    }

    // Obtener ubicación actual
    return await Geolocator.getCurrentPosition(locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
      timeLimit: Duration(minutes: 1)
      )
    );
  }
}