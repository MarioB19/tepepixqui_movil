import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaEstaciones extends StatefulWidget {
  @override
  _MapaEstacionesState createState() => _MapaEstacionesState();
}

class _MapaEstacionesState extends State<MapaEstaciones> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  Estacion? estacionSeleccionada;

  static final CameraPosition posicionInicial = CameraPosition(
    target: LatLng(20.6241, -103.4843),
    zoom: 10,
  );

  final List<Estacion> estaciones = [
    Estacion(
      id: 1,
      nombre: 'Estación 1',
      posicion: LatLng(20.6331250, -103.5598250),
      datos: DatosEstacion(
        temperatura: '25°C',
        humedad: '60%',
        co2: '400 ppm',
        co: '10 ppm',
        humo: '0.05 mg/m3',
        viento: '15 km/h',
      ),
    ),
    Estacion(
      id: 2,
      nombre: 'Estación 2',
      posicion: LatLng(20.6241, -103.4843),
      datos: DatosEstacion(
        temperatura: '26°C',
        humedad: '58%',
        co2: '410 ppm',
        co: '12 ppm',
        humo: '0.07 mg/m3',
        viento: '10 km/h',
      ),
    ),
    Estacion(
      id: 3,
      nombre: 'Estación 3',
      posicion: LatLng(20.6720, -103.4857),
      datos: DatosEstacion(
        temperatura: '24°C',
        humedad: '65%',
        co2: '420 ppm',
        co: '8 ppm',
        humo: '0.04 mg/m3',
        viento: '12 km/h',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _crearMarcadoresYCirculos();
  }

  void _crearMarcadoresYCirculos() {
    for (var estacion in estaciones) {
      markers.add(
        Marker(
          markerId: MarkerId(estacion.id.toString()),
          position: estacion.posicion,
          onTap: () {
            setState(() {
              estacionSeleccionada = estacion;
            });
          },
        ),
      );

      circles.add(
        Circle(
          circleId: CircleId(estacion.id.toString()),
          center: estacion.posicion,
          radius: 5000, // 5 km de radio
          fillColor: Colors.lightBlue.withOpacity(0.3),
          strokeColor: Colors.blue,
          strokeWidth: 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Estaciones'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'El proyecto Tepepixqui utiliza estaciones con sensores para detectar tempranamente incendios forestales. Cada estación monitorea temperatura, humedad, niveles de CO2, CO, humo y velocidad del viento, y tiene un área de cobertura de 5 km a la redonda.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: posicionInicial,
              markers: markers,
              circles: circles,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
          if (estacionSeleccionada != null)
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(estacionSeleccionada!.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Temperatura: ${estacionSeleccionada!.datos.temperatura}'),
                  Text('Humedad: ${estacionSeleccionada!.datos.humedad}'),
                  Text('CO2: ${estacionSeleccionada!.datos.co2}'),
                  Text('CO: ${estacionSeleccionada!.datos.co}'),
                  Text('Humo: ${estacionSeleccionada!.datos.humo}'),
                  Text('Viento: ${estacionSeleccionada!.datos.viento}'),
                  SizedBox(height: 8),
                  Text(
                    'Esta estación forma parte del sistema Tepepixqui para la detección temprana de incendios forestales.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Estacion {
  final int id;
  final String nombre;
  final LatLng posicion;
  final DatosEstacion datos;

  Estacion({required this.id, required this.nombre, required this.posicion, required this.datos});
}

class DatosEstacion {
  final String temperatura;
  final String humedad;
  final String co2;
  final String co;
  final String humo;
  final String viento;

  DatosEstacion({
    required this.temperatura,
    required this.humedad,
    required this.co2,
    required this.co,
    required this.humo,
    required this.viento,
  });
}