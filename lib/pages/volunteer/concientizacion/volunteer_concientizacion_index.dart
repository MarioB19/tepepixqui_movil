import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConcientizacionPage extends StatefulWidget {
  @override
  _ConcientizacionPageState createState() => _ConcientizacionPageState();
}

class _ConcientizacionPageState extends State<ConcientizacionPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  Estacion? estacionSeleccionada;
  bool informacionLeida = false;

  static final CameraPosition posicionInicial = CameraPosition(
    target: LatLng(20.6596988, -103.3496092),
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
          radius: 1000, // 1 km de radio
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
        title: Text('Concientización'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIntroduccion(),
            _buildMapa(),
            if (estacionSeleccionada != null) _buildDatosEstacion(),
            _buildContenidoEducativo(),
            _buildBotonVerificacion(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduccion() {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'El proyecto Tepepixqui utiliza estaciones con sensores para detectar tempranamente incendios forestales. Cada estación monitorea temperatura, humedad, niveles de CO2, CO, humo y velocidad del viento, y tiene un área de cobertura de 1 km a la redonda.',
          style: TextStyle(fontSize: 18, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildMapa() {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: GoogleMap(
        initialCameraPosition: posicionInicial,
        markers: markers,
        circles: circles,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }

  Widget _buildDatosEstacion() {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(estacionSeleccionada!.nombre, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Temperatura: ${estacionSeleccionada!.datos.temperatura}', style: TextStyle(fontSize: 18)),
            Text('Humedad: ${estacionSeleccionada!.datos.humedad}', style: TextStyle(fontSize: 18)),
            Text('CO2: ${estacionSeleccionada!.datos.co2}', style: TextStyle(fontSize: 18)),
            Text('CO: ${estacionSeleccionada!.datos.co}', style: TextStyle(fontSize: 18)),
            Text('Humo: ${estacionSeleccionada!.datos.humo}', style: TextStyle(fontSize: 18)),
            Text('Viento: ${estacionSeleccionada!.datos.viento}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              'Esta estación forma parte del sistema Tepepixqui para la detección temprana de incendios forestales.',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContenidoEducativo() {
    return Column(
      children: [
        _buildSeccionEducativa(
          'Prevención de Incendios Forestales',
          'Los incendios forestales son una amenaza seria para nuestros ecosistemas. Aprende cómo prevenirlos:',
          [
            'No arrojes colillas de cigarrillos en áreas boscosas',
            'Evita hacer fogatas en zonas no autorizadas',
            'Reporta inmediatamente cualquier señal de humo o fuego',
            'Participa en programas de reforestación',
          ],
        ),
        _buildSeccionEducativa(
          'Qué hacer en caso de un Incendio Forestal',
          'Si te encuentras cerca de un incendio forestal, sigue estas recomendaciones:',
          [
            'Mantén la calma y evacúa el área inmediatamente',
            'Sigue las instrucciones de las autoridades',
            'No intentes combatir el fuego por tu cuenta',
            'Ayuda a personas vulnerables a evacuar',
          ],
        ),
        _buildEspacioInfografia(),
      ],
    );
  }

  Widget _buildSeccionEducativa(String titulo, String introduccion, List<String> puntos) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(introduccion, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            ...puntos.map((punto) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Expanded(child: Text(punto, style: TextStyle(fontSize: 18))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildEspacioInfografia() {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/infografia.png',
          fit: BoxFit.cover,
          height: 700,
        ),
      ),
    );
  }

  Widget _buildBotonVerificacion() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
        onPressed: informacionLeida ? null : _mostrarDialogoConfirmacion,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'He leído la información y estoy de acuerdo',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Felicidades', style: TextStyle(fontSize: 24)),
          content: Text(
            'Has completado la lectura del material educativo. Ahora eres un brigadista verificado.',
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Entendido', style: TextStyle(fontSize: 18)),
              onPressed: () {
                setState(() {
                  informacionLeida = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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