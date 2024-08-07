import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DifusionPage extends StatefulWidget {
  @override
  _DifusionPageState createState() => _DifusionPageState();
}

class _DifusionPageState extends State<DifusionPage> {
  List<ONG> ongsDisponibles = [
    ONG(id: '1', nombre: 'Protectores del Bosque', logo: 'assets/images/ong1.jpg', seguida: true),
    ONG(id: '2', nombre: 'Guardianes Verdes', logo: 'assets/images/ong2.jpg', seguida: false),
    ONG(id: '3', nombre: 'Escuadrón Águila', logo: 'assets/images/ong3.jpg', seguida: true),
    ONG(id: '4', nombre: 'Bomberos Forestales', logo: 'assets/images/ong4.jpg', seguida: false),
  ];

  List<Reporte> reportes = [
    Reporte(
      id: '1',
      ubicacion: 'Bosque de la Primavera, Jalisco',
      fecha: DateTime.now().subtract(Duration(days: 2)),
      estado: 'Activo',
      descripcion: 'Incendio de nivel medio, afectando aproximadamente 50 hectáreas.',
      ongReportada: 'Protectores del Bosque',
    ),
    Reporte(
      id: '2',
      ubicacion: 'Sierra de Manantlán, Colima',
      fecha: DateTime.now().subtract(Duration(days: 1)),
      estado: 'Controlado',
      descripcion: 'Incendio controlado, en fase de enfriamiento y vigilancia.',
      ongReportada: 'Escuadrón Águila',
    ),
  ];

  List<Mensaje> mensajesBrigada = [
    Mensaje(texto: 'Equipo, nos reuniremos en el punto de control a las 8:00 AM.', autor: 'Coordinador', fecha: DateTime.now().subtract(Duration(hours: 2))),
    Mensaje(texto: 'Entendido, estaré allí.', autor: 'Tú', fecha: DateTime.now().subtract(Duration(hours: 1))),
    Mensaje(texto: 'Recuerden traer suficiente agua y protección solar.', autor: 'Coordinador', fecha: DateTime.now().subtract(Duration(minutes: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Difusión'),
   
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReportButton(),
              SizedBox(height: 24),
              _buildONGsSection(),
              SizedBox(height: 24),
              _buildReportesSection(),
              SizedBox(height: 24),
              _buildChatBrigada(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportButton() {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.warning, color: Colors.white),
        label: Text('Reportar Incendio', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: _mostrarFormularioReporte,
      ),
    );
  }

  Widget _buildONGsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ONGs', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ongsDisponibles.length,
            itemBuilder: (context, index) {
              final ong = ongsDisponibles[index];
              return Container(
                width: 80,
                margin: EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(ong.logo),
                    ),
                    SizedBox(height: 4),
                    Text(ong.nombre, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                    IconButton(
                      icon: Icon(ong.seguida ? Icons.star : Icons.star_border, color: Colors.amber),
                      onPressed: () => _toggleSeguirONG(ong),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReportesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Últimos Reportes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ...reportes.map((reporte) => _buildReporteCard(reporte)).toList(),
      ],
    );
  }

  Widget _buildReporteCard(Reporte reporte) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(reporte.ubicacion, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Estado: ${reporte.estado}', style: TextStyle(color: reporte.estado == 'Activo' ? Colors.red : Colors.green)),
            Text('Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(reporte.fecha)}'),
            SizedBox(height: 8),
            Text(reporte.descripcion),
            SizedBox(height: 8),
            Text('Reportado por: ${reporte.ongReportada}', style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBrigada() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chat de Brigada', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: mensajesBrigada.length,
            itemBuilder: (context, index) {
              final mensaje = mensajesBrigada[index];
              return ListTile(
                title: Text(mensaje.texto),
                subtitle: Text('${mensaje.autor} - ${DateFormat('HH:mm').format(mensaje.fecha)}'),
                leading: CircleAvatar(
                  child: Text(mensaje.autor[0]),
                  backgroundColor: mensaje.autor == 'Tú' ? Colors.blue : Colors.grey,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: () {
                // Lógica para enviar mensaje
              },
            ),
          ],
        ),
      ],
    );
  }

  void _mostrarFormularioReporte() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reportar Incendio'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(decoration: InputDecoration(labelText: 'Ubicación')),
                TextField(decoration: InputDecoration(labelText: 'Descripción')),
                DropdownButton<String>(
                  hint: Text('Seleccionar ONG'),
                  items: ongsDisponibles
                      .map((ong) => DropdownMenuItem(
                            value: ong.id,
                            child: Text(ong.nombre),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    // Lógica para seleccionar ONG
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Enviar Reporte'),
              onPressed: () {
                // Lógica para enviar reporte
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reporte enviado con éxito')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleSeguirONG(ONG ong) {
    setState(() {
      ong.seguida = !ong.seguida;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ong.seguida ? 'Ahora sigues a ${ong.nombre}' : 'Has dejado de seguir a ${ong.nombre}'),
      ),
    );
  }
}

class ONG {
  final String id;
  final String nombre;
  final String logo;
  bool seguida;

  ONG({required this.id, required this.nombre, required this.logo, required this.seguida});
}

class Reporte {
  final String id;
  final String ubicacion;
  final DateTime fecha;
  final String estado;
  final String descripcion;
  final String ongReportada;

  Reporte({
    required this.id,
    required this.ubicacion,
    required this.fecha,
    required this.estado,
    required this.descripcion,
    required this.ongReportada,
  });
}

class Mensaje {
  final String texto;
  final String autor;
  final DateTime fecha;

  Mensaje({required this.texto, required this.autor, required this.fecha});
}