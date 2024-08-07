import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonacionesPage extends StatefulWidget {
  @override
  _DonacionesPageState createState() => _DonacionesPageState();
}

class _DonacionesPageState extends State<DonacionesPage> {
  List<EventoDonacion> eventosActivos = [
    EventoDonacion(
      id: '1',
      titulo: 'Reforestación Bosque de la Primavera',
      ong: 'Protectores del Bosque',
      fecha: DateTime.now().add(Duration(days: 10)),
      lugar: 'Bosque de la Primavera, Jalisco',
      descripcion: 'Únete a nosotros para plantar 1000 árboles y restaurar áreas afectadas por incendios.',
      tiposDonacionAceptados: ['Árboles', 'Herramientas', 'Agua'],
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJIBLMgeg71jeMKoauFWEGGsHJjH7NmUkDOA&s',
    ),
    EventoDonacion(
      id: '2',
      titulo: 'Colecta de Equipos de Protección',
      ong: 'Guardianes Verdes',
      fecha: DateTime.now().add(Duration(days: 5)),
      lugar: 'Plaza Principal, Guadalajara',
      descripcion: 'Recolección de equipos de protección para brigadistas forestales.',
      tiposDonacionAceptados: ['Cascos', 'Guantes', 'Botas', 'Máscaras'],
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-AYJQsjmVbmLrwy0PPJH-Hjgg0RHYrRs0tA&s',
    ),
  ];

  List<EventoDonacion> eventosInscritos = [
    EventoDonacion(
      id: '3',
      titulo: 'Campaña de Concientización',
      ong: 'Escuadrón Águila',
      fecha: DateTime.now().add(Duration(days: 15)),
      lugar: 'Parque Metropolitano, Guadalajara',
      descripcion: 'Evento educativo para concientizar sobre la prevención de incendios forestales.',
      tiposDonacionAceptados: ['Materiales educativos', 'Refrigerios'],
      imagenUrl: 'https://www.comunicarseweb.com/sites/default/files/styles/galeria_noticias/public/biblioteca/images//1319548646_Voluntarios_LAN_durante_la_plantacion_de_los_100_arboles.JPG?itok=axF3Zyu6',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones y Eventos'),
   
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSeccionEventosActivos(),
              SizedBox(height: 24),
              _buildSeccionHistorial(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeccionEventosActivos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eventos Activos de Donación',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[800]),
        ),
        SizedBox(height: 16),
        ...eventosActivos.map((evento) => _buildTarjetaEvento(evento, true)).toList(),
      ],
    );
  }

  Widget _buildSeccionHistorial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu Historial de Participación',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
        SizedBox(height: 16),
        ...eventosInscritos.map((evento) => _buildTarjetaEvento(evento, false)).toList(),
      ],
    );
  }

  Widget _buildTarjetaEvento(EventoDonacion evento, bool esActivo) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              evento.imagenUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.error)),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evento.titulo,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Organizado por: ${evento.ong}', style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(DateFormat('dd/MM/yyyy').format(evento.fecha)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(child: Text(evento.lugar)),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  evento.descripcion,
                  style: TextStyle(fontSize: 14,),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: evento.tiposDonacionAceptados
                      .map((tipo) => Chip(
                            label: Text(tipo, style: TextStyle(fontWeight: FontWeight.bold),),
                            backgroundColor: Color.fromARGB(255, 115, 96, 2),
                          ))
                      .toList(),
                ),
                SizedBox(height: 16),
                if (esActivo)
                  ElevatedButton(
                    child: Text('Inscribirse'),
                    onPressed: () => _inscribirseEnEvento(evento),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  )
                else
                  Text(
                    evento.fecha.isAfter(DateTime.now()) ? 'Próximamente' : 'Evento Pasado',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: evento.fecha.isAfter(DateTime.now()) ? Colors.blue : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _inscribirseEnEvento(EventoDonacion evento) {
    setState(() {
      eventosActivos.remove(evento);
      eventosInscritos.add(evento);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Te has inscrito en el evento: ${evento.titulo}')),
    );
  }
}

class EventoDonacion {
  final String id;
  final String titulo;
  final String ong;
  final DateTime fecha;
  final String lugar;
  final String descripcion;
  final List<String> tiposDonacionAceptados;
  final String imagenUrl;

  EventoDonacion({
    required this.id,
    required this.titulo,
    required this.ong,
    required this.fecha,
    required this.lugar,
    required this.descripcion,
    required this.tiposDonacionAceptados,
    required this.imagenUrl,
  });
}