import 'package:flutter/material.dart';

class VistaDonacionesRecursos extends StatefulWidget {
  @override
  _VistaDonacionesRecursosState createState() => _VistaDonacionesRecursosState();
}

class _VistaDonacionesRecursosState extends State<VistaDonacionesRecursos> {
  List<EventoRecursos> eventos = [
    EventoRecursos(
      nombre: "Reforestación Parque Nacional",
      descripcion: "Necesitamos árboles nativos y herramientas para reforestar áreas afectadas por incendios.",
      recursosPrincipales: ["Árboles nativos", "Palas", "Guantes"],
      cantidadObjetivo: 5000,
      unidad: "árboles y herramientas",
      estado: 'Activo',
    ),
    EventoRecursos(
      nombre: "Equipamiento Brigada Forestal",
      descripcion: "Recolección de equipo de protección personal para bomberos forestales voluntarios.",
      recursosPrincipales: ["Cascos", "Botas", "Trajes ignífugos"],
      cantidadObjetivo: 50,
      unidad: "equipos completos",
      estado: 'Activo',
    ),
    EventoRecursos(
      nombre: "Herramientas para Cortafuegos",
      descripcion: "Solicitamos herramientas para crear y mantener cortafuegos en áreas de alto riesgo.",
      recursosPrincipales: ["Hachas", "Motosierras", "Rastrillos"],
      cantidadObjetivo: 100,
      unidad: "herramientas",
      estado: 'Activo',
    ),
    EventoRecursos(
      nombre: "Suministros de Agua",
      descripcion: "Necesitamos mangueras y cubetas para el transporte de agua en zonas de difícil acceso.",
      recursosPrincipales: ["Mangueras", "Cubetas", "Mochilas de agua"],
      cantidadObjetivo: 200,
      unidad: "unidades",
      estado: 'Finalizado',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          return EventoRecursosCard(evento: eventos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _mostrarDialogoCrearEvento();
        },
        backgroundColor: Colors.green[600],
      ),
    );
  }

  void _mostrarDialogoCrearEvento() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Nuevo Evento de Donación de Recursos'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Nombre del evento"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Descripción"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Recursos principales (separados por coma)"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Cantidad objetivo"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Unidad de medida"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Crear'),
              onPressed: () {
                // Aquí iría la lógica para crear el evento
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class EventoRecursosCard extends StatelessWidget {
  final EventoRecursos evento;

  EventoRecursosCard({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              evento.nombre,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(evento.descripcion),
            SizedBox(height: 10),
            Text('Recursos principales:',
                 style: TextStyle(fontWeight: FontWeight.w500)),
            ...evento.recursosPrincipales.map((recurso) => 
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                    SizedBox(width: 5),
                    Text(recurso),
                  ],
                ),
              )
            ).toList(),
            SizedBox(height: 10),
            Text('Objetivo: ${evento.cantidadObjetivo} ${evento.unidad}', 
                 style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: evento.estado == 'Activo' ? Colors.green[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Estado: ${evento.estado}',
                style: TextStyle(color: evento.estado == 'Activo' ? Colors.green[800] : Colors.grey[800]),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.edit, size: 16),
                  label: Text('Editar'),
                  onPressed: () {
                    // Lógica para editar el evento
                  },
                ),
                TextButton.icon(
                  icon: Icon(Icons.people, size: 16),
                  label: Text('Ver Donantes'),
                  onPressed: () {
                    // Lógica para ver la lista de donantes
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventoRecursos {
  String nombre;
  String descripcion;
  List<String> recursosPrincipales;
  int cantidadObjetivo;
  String unidad;
  String estado;

  EventoRecursos({
    required this.nombre,
    required this.descripcion,
    required this.recursosPrincipales,
    required this.cantidadObjetivo,
    required this.unidad,
    this.estado = 'Activo',
  });
}