import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Time {
  static void setupTimeZone() {
    tz.initializeTimeZones(); // Inicializa las zonas horarias
  }

  static DateTime getNowInMexicoCity() {
    final location = tz.getLocation('America/Mexico_City');
    final nowInMexicoCity = tz.TZDateTime.now(location);
    return nowInMexicoCity;
  }
}
