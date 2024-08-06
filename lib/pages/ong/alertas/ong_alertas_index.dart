import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VistaAlertas extends StatefulWidget {
  @override
  _VistaAlertasState createState() => _VistaAlertasState();
}

class _VistaAlertasState extends State<VistaAlertas> {
  final List<Map<String, dynamic>> reportesEstaciones = [
    {
      'id': 1,
      'estacion': 'Bosque Río Bravo',
      'nivel': 'Alto',
      'fecha': DateTime.now().subtract(Duration(hours: 2)),
      'descripcion': 'Incendio forestal detectado cerca del río.',
      'posicion': LatLng(20.6331250, -103.5598250)
    },
    {
      'id': 2,
      'estacion': 'Bosque Sierra Madre',
      'nivel': 'Medio',
      'fecha': DateTime.now().subtract(Duration(hours: 5)),
      'descripcion': 'Fuego controlado en la ladera del bosque.',
      'posicion': LatLng(20.6241, -103.4843)
    },
    {
      'id': 3,
      'estacion': 'Bosque Costero',
      'nivel': 'Bajo',
      'fecha': DateTime.now().subtract(Duration(hours: 8)),
      'descripcion': 'Pequeño incendio cerca de la costa, bajo control.',
      'posicion': LatLng(20.6720, -103.4857)
    },


  ];

  final List<Map<String, dynamic>> reportesUsuarios = [
    {
      'id': 1,
      'usuario': 'María G.',
      'descripcion': 'Incendio forestal avistado cerca del sendero principal.',
      'fecha': DateTime.now().subtract(Duration(hours: 1))
    },
    {
      'id': 2,
      'usuario': 'Juan P.',
      'descripcion': 'Fuego en la ladera del bosque, propagándose rápidamente.',
      'fecha': DateTime.now().subtract(Duration(hours: 4))
    },
    {
      'id': 3,
      'usuario': 'Ana L.',
      'descripcion': 'Humo visible en el río del bosque, posible incendio.',
      'fecha': DateTime.now().subtract(Duration(hours: 6))
    },
    {
      'id': 4,
      'usuario': 'Carlos M.',
      'descripcion': 'Incendio forestal en el parque nacional, llamas altas.',
      'fecha': DateTime.now().subtract(Duration(hours: 2))
    },
    {
      'id': 5,
      'usuario': 'Laura S.',
      'descripcion': 'Incendio forestal activo en el área forestal, viento fuerte.',
      'fecha': DateTime.now().subtract(Duration(hours: 3))
    },
  ];

  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  static final CameraPosition posicionInicial = CameraPosition(
    target: LatLng(20.6331250, -103.5598250),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _crearMarcadoresYCirculos();
  }

  void _crearMarcadoresYCirculos() {
    for (var estacion in reportesEstaciones) {
      markers.add(
        Marker(
          markerId: MarkerId(estacion['id'].toString()),
          position: estacion['posicion'],
          onTap: () {
            _mostrarInfoEstacion(estacion);
          },
        ),
      );

      circles.add(
        Circle(
          circleId: CircleId(estacion['id'].toString()),
          center: estacion['posicion'],
          radius: 1000, // 5 km de radio
          fillColor: Colors.red.withOpacity(0.3),
          strokeColor: Colors.red,
          strokeWidth: 1,
        ),
      );
    }
  }

  void _mostrarInfoEstacion(Map<String, dynamic> estacion) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                estacion['estacion'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('Nivel: ${estacion['nivel']}'),
              Text('Descripción: ${estacion['descripcion']}'),
              Text('Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(estacion['fecha'])}'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Mapa interactivo
          Expanded(
            flex: 3,
            child: GoogleMap(
              initialCameraPosition: posicionInicial,
              markers: markers,
              circles: circles,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
          // Sección de reportes
          Expanded(
            flex: 2,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Reportes de Estaciones'),
                      Tab(text: 'Reportes de Usuarios'),
                    ],
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.grey,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Lista de reportes de estaciones
                        ListView.builder(
                          itemCount: reportesEstaciones.length,
                          itemBuilder: (context, index) {
                            final reporte = reportesEstaciones[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: ListTile(
                                leading: Icon(_getNivelIcon(reporte['nivel']),
                                    color: _getNivelColor(reporte['nivel'])),
                                title: Text(reporte['estacion']),
                                subtitle: Text(
                                    'Nivel: ${reporte['nivel']}\n${reporte['descripcion']}'),
                                trailing: Text(DateFormat('dd/MM HH:mm')
                                    .format(reporte['fecha'])),
                                onTap: () => _mostrarInfoEstacion(reporte),
                              ),
                            );
                          },
                        ),
                        // Lista de reportes de usuarios
                        ListView.builder(
                          itemCount: reportesUsuarios.length,
                          itemBuilder: (context, index) {
                            final reporte = reportesUsuarios[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                    child: Text(reporte['usuario'][0])),
                                title: Text(reporte['descripcion']),
                                subtitle: Text(
                                    'Reportado por: ${reporte['usuario']}'),
                                trailing: Text(DateFormat('dd/MM HH:mm')
                                    .format(reporte['fecha'])),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí iría la lógica para abrir los filtros
        },
        child: Icon(Icons.filter_list),
        tooltip: 'Filtros',
        backgroundColor: Colors.teal,
      ),
    );
  }

  IconData _getNivelIcon(String nivel) {
    switch (nivel) {
      case 'Bajo':
        return Icons.info_outline;
      case 'Medio':
        return Icons.warning_amber_rounded;
      case 'Alto':
        return Icons.error_outline;
      case 'Crítico':
        return Icons.dangerous_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Color _getNivelColor(String nivel) {
    switch (nivel) {
      case 'Bajo':
        return Colors.green;
      case 'Medio':
        return Colors.yellow;
      case 'Alto':
        return Colors.orange;
      case 'Crítico':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
