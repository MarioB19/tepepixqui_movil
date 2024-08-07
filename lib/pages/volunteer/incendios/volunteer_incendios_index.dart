import 'package:flutter/material.dart';

class IncendiosPage extends StatefulWidget {
  @override
  _IncendiosPageState createState() => _IncendiosPageState();
}

class _IncendiosPageState extends State<IncendiosPage> {
  List<Incendio> incendios = [
    Incendio(
      id: '1',
      ubicacion: 'Bosque de la Primavera, Jalisco',
      estado: 'Activo',
      detalles: 'Incendio de nivel medio, afectando aproximadamente 50 hectáreas.',
      brigadas: [
        Brigada(
          id: '1',
          nombreONG: 'Protectores del Bosque',
          fotoPerfilONG: 'assets/images/ong1.jpg',
          estado: 'Activa',
          cuposDisponibles: 5,
          detalles: 'Brigada especializada en combate directo de incendios forestales.',
        ),
        Brigada(
          id: '2',
          nombreONG: 'Guardianes Verdes',
          fotoPerfilONG: 'assets/images/ong2.jpg',
          estado: 'Activa',
          cuposDisponibles: 0,
          detalles: 'Brigada de apoyo logístico y suministro de agua.',
        ),
      ],
    ),
    Incendio(
      id: '2',
      ubicacion: 'Sierra de Manantlán, Colima',
      estado: 'Activo',
      detalles: 'Incendio de gran magnitud, afectando más de 100 hectáreas de bosque.',
      brigadas: [
        Brigada(
          id: '3',
          nombreONG: 'Escuadrón Águila',
          fotoPerfilONG: 'assets/images/ong3.jpg',
          estado: 'Activa',
          cuposDisponibles: 3,
          detalles: 'Brigada especializada en evaluación de daños y coordinación.',
        ),
      ],
    ),
    Incendio(
      id: '3',
      ubicacion: 'Nevado de Colima, Jalisco',
      estado: 'Controlado',
      detalles: 'Incendio controlado, en fase de enfriamiento y vigilancia.',
      brigadas: [
        Brigada(
          id: '4',
          nombreONG: 'Bomberos Forestales',
          fotoPerfilONG: 'assets/images/ong1.jpg',
          estado: 'En espera',
          cuposDisponibles: 2,
          detalles: 'Brigada en espera para asegurar que no haya reactivaciones.',
        ),
      ],
    ),
  ];

  List<Incendio> incendiosFiltrados = [];
  Incendio? incendioSeleccionado;
  Brigada? brigadaSeleccionada;
  bool usuarioVerificado = true; // Simula que el usuario está verificado

  List<Brigada> brigadasUsuario = [
    Brigada(
      id: '5',
      nombreONG: 'Protectores del Bosque',
      fotoPerfilONG: 'assets/images/ong1.jpg',
      estado: 'Activa',
      cuposDisponibles: 0,
      detalles: 'Brigada de prevención y educación comunitaria.',
    ),
    Brigada(
      id: '6',
      nombreONG: 'Guardianes Verdes',
      fotoPerfilONG: 'assets/images/ong2.jpg',
      estado: 'Finalizada',
      cuposDisponibles: 0,
      detalles: 'Brigada de reforestación post-incendio.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    incendiosFiltrados = incendios;
  }

  void filtrarIncendios(String ubicacion) {
    setState(() {
      incendiosFiltrados = incendios
          .where((incendio) =>
              incendio.ubicacion.toLowerCase().contains(ubicacion.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incendios Forestales'),

      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: incendioSeleccionado == null
                ? _buildListaIncendios()
                : _buildDetalleIncendio(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarHistorialBrigadas,
        child: Icon(Icons.history),
        tooltip: 'Historial de participación',
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.red[100],
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Filtrar por ubicación',
          prefixIcon: Icon(Icons.search, color: Colors.red[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: filtrarIncendios,
      ),
    );
  }

  Widget _buildListaIncendios() {
    return ListView.builder(
      itemCount: incendiosFiltrados.length,
      itemBuilder: (context, index) {
        final incendio = incendiosFiltrados[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(
              Icons.local_fire_department,
              color: incendio.estado == 'Activo' ? Colors.red : Colors.green,
              size: 40,
            ),
            title: Text(
              incendio.ubicacion,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Estado: ${incendio.estado}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              setState(() {
                incendioSeleccionado = incendio;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildDetalleIncendio() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              incendioSeleccionado!.ubicacion,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildEstadoChip(incendioSeleccionado!.estado),
            SizedBox(height: 16),
            Text(
              incendioSeleccionado!.detalles,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Brigadas organizadas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...incendioSeleccionado!.brigadas.map(_buildBrigadaItem).toList(),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    incendioSeleccionado = null;
                    brigadaSeleccionada = null;
                  });
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Volver a la lista'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstadoChip(String estado) {
    return Chip(
      label: Text(
        estado,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: estado == 'Activo' ? Colors.red[700] : Colors.green,
    );
  }

  Widget _buildBrigadaItem(Brigada brigada) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(brigada.fotoPerfilONG),
        ),
        title: Text(
          brigada.nombreONG,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Estado: ${brigada.estado}'),
        trailing: Icon(Icons.info_outline),
        onTap: () => _mostrarDetalleBrigada(brigada),
      ),
    );
  }

  void _mostrarDetalleBrigada(Brigada brigada) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(brigada.nombreONG),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEstadoChip(brigada.estado),
              SizedBox(height: 8),
              Text('Cupos disponibles: ${brigada.cuposDisponibles}'),
              SizedBox(height: 8),
              Text(brigada.detalles),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
            if (brigada.estado == 'Activa' &&
                brigada.cuposDisponibles > 0 &&
                usuarioVerificado)
              ElevatedButton(
                onPressed: () {
                  _inscribirseEnBrigada(brigada);
                  Navigator.of(context).pop();
                },
                child: Text('Inscribirse'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
          ],
        );
      },
    );
  }

  void _inscribirseEnBrigada(Brigada brigada) {
    setState(() {
      brigada.cuposDisponibles--;
      brigadasUsuario.add(brigada);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Te has inscrito en la brigada ${brigada.nombreONG}')),
    );
  }

  void _mostrarHistorialBrigadas() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Historial de Participación'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildHistorialSection('Brigadas Activas', 'Activa'),
                SizedBox(height: 16),
                _buildHistorialSection('Brigadas Pasadas', 'Finalizada'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistorialSection(String title, String estado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ...brigadasUsuario
            .where((b) => b.estado == estado)
            .map((b) => ListTile(
                  title: Text(b.nombreONG),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(b.fotoPerfilONG),
                  ),
                ))
            .toList(),
      ],
    );
  }
}

class Incendio {
  final String id;
  final String ubicacion;
  final String estado;
  final String detalles;
  final List<Brigada> brigadas;

  Incendio({
    required this.id,
    required this.ubicacion,
    required this.estado,
    required this.detalles,
    required this.brigadas,
  });
}

class Brigada {
  final String id;
  final String nombreONG;
  final String fotoPerfilONG;
  final String estado;
  int cuposDisponibles;
  final String detalles;

  Brigada({
    required this.id,
    required this.nombreONG,
    required this.fotoPerfilONG,
    required this.estado,
    required this.cuposDisponibles,
    required this.detalles,
  });
}