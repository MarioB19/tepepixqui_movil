import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




// Modelo de Brigada
class Brigade {
  final String id;
  String name;
  DateTime creationDate;
  String status;
  int participantsCount;
  String associatedFireLocation;
  String description;
  DateTime? startDate;
  DateTime? endDate;
  int maxParticipants;
  List<String> equipment;
  String specialization;

  Brigade({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.status,
    required this.participantsCount,
    required this.associatedFireLocation,
    this.description = '',
    this.startDate,
    this.endDate,
    this.maxParticipants = 0,
    this.equipment = const [],
    required this.specialization,
  });
}

// Servicio de Datos Ficticios
class MockBrigadeService {
  static final List<Brigade> _brigades = [
    Brigade(
      id: '1',
      name: 'Águilas del Bosque',
      creationDate: DateTime.now().subtract(Duration(days: 30)),
      status: 'Activa',
      participantsCount: 15,
      associatedFireLocation: 'Sierra de Guadalupe',
      description: 'Brigada especializada en combate directo de incendios forestales.',
      startDate: DateTime.now().subtract(Duration(days: 2)),
      endDate: null,
      maxParticipants: 20,
      equipment: ['Motobombas', 'Hachas', 'Palas', 'Radios'],
      specialization: 'Combate directo',
    ),
    Brigade(
      id: '2',
      name: 'Guardianes del Agua',
      creationDate: DateTime.now().subtract(Duration(days: 45)),
      status: 'En espera',
      participantsCount: 10,
      associatedFireLocation: 'Reserva Natural Los Pinos',
      description: 'Equipo de apoyo logístico especializado en suministro de agua.',
      startDate: null,
      endDate: null,
      maxParticipants: 15,
      equipment: ['Camiones cisterna', 'Mangueras de alta presión', 'Bombas portátiles'],
      specialization: 'Apoyo logístico',
    ),
    Brigade(
      id: '3',
      name: 'Escuadrón Fénix',
      creationDate: DateTime.now().subtract(Duration(days: 60)),
      status: 'Finalizada',
      participantsCount: 25,
      associatedFireLocation: 'Parque Nacional El Tepozteco',
      description: 'Brigada de gran escala para incendios forestales extensos.',
      startDate: DateTime.now().subtract(Duration(days: 10)),
      endDate: DateTime.now().subtract(Duration(days: 5)),
      maxParticipants: 30,
      equipment: ['Helicópteros', 'Vehículos todo terreno', 'Equipos de comunicación avanzados'],
      specialization: 'Combate aéreo y terrestre',
    ),
  ];

  static List<Brigade> getActiveBrigades() {
    return _brigades.where((brigade) => brigade.status != 'Finalizada').toList();
  }

  static List<Brigade> getPastBrigades() {
    return _brigades.where((brigade) => brigade.status == 'Finalizada').toList();
  }

  static void updateBrigade(Brigade updatedBrigade) {
    final index = _brigades.indexWhere((brigade) => brigade.id == updatedBrigade.id);
    if (index != -1) {
      _brigades[index] = updatedBrigade;
    }
  }

  static List<String> getMockMessages() {
    return [
      'Equipo A, diríjanse al sector norte.',
      'Necesitamos refuerzos en la zona este.',
      'Reporte de condiciones: viento fuerte del suroeste.',
      'Equipo de agua, prepárense para apoyar en 10 minutos.',
      'Evacuación completada en el área residencial cercana.',
      'Solicitud de más equipos de protección personal.',
      'El fuego está contenido en un 60%.',
      'Cambio de turno para el equipo nocturno a las 20:00.',
    ];
  }
}

// Vista Principal de Brigadas
class BrigadesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeBrigades = MockBrigadeService.getActiveBrigades();
    final pastBrigades = MockBrigadeService.getPastBrigades();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brigadas contra Incendios Forestales'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Activas'),
              Tab(text: 'Pasadas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBrigadeList(context, activeBrigades),
            _buildBrigadeList(context, pastBrigades),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Aquí iría la lógica para crear una nueva brigada
          },
          child: Icon(Icons.add),
          tooltip: 'Crear nueva brigada',
        ),
      ),
    );
  }

  Widget _buildBrigadeList(BuildContext context, List<Brigade> brigades) {
    return ListView.builder(
      itemCount: brigades.length,
      itemBuilder: (context, index) {
        final brigade = brigades[index];
        return BrigadeListItem(
          brigade: brigade,
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditBrigadeScreen(brigade: brigade),
              ),
            );
          },
          onChat: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BrigadeChatScreen(brigadeId: brigade.id),
              ),
            );
          },
        );
      },
    );
  }
}

// Widget de Elemento de Lista de Brigadas
class BrigadeListItem extends StatelessWidget {
  final Brigade brigade;
  final VoidCallback onEdit;
  final VoidCallback onChat;

  const BrigadeListItem({
    Key? key,
    required this.brigade,
    required this.onEdit,
    required this.onChat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              brigade.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Especialización: ${brigade.specialization}'),
            Text('Estado: ${brigade.status}'),
            Text('Participantes: ${brigade.participantsCount}/${brigade.maxParticipants}'),
            Text('Ubicación del incendio: ${brigade.associatedFireLocation}'),
            Text('Fecha de creación: ${DateFormat('dd/MM/yyyy').format(brigade.creationDate)}'),
            SizedBox(height: 8),
            Text('Equipamiento: ${brigade.equipment.join(", ")}'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onEdit,
                  child: Text('Editar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onChat,
                  child: Text('Chat'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Edición de Brigada
class EditBrigadeScreen extends StatefulWidget {
  final Brigade brigade;

  const EditBrigadeScreen({Key? key, required this.brigade}) : super(key: key);

  @override
  _EditBrigadeScreenState createState() => _EditBrigadeScreenState();
}

class _EditBrigadeScreenState extends State<EditBrigadeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _maxParticipantsController;
  late TextEditingController _equipmentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.brigade.name);
    _descriptionController = TextEditingController(text: widget.brigade.description);
    _maxParticipantsController = TextEditingController(text: widget.brigade.maxParticipants.toString());
    _equipmentController = TextEditingController(text: widget.brigade.equipment.join(', '));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Brigada'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre de la brigada'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _maxParticipantsController,
              decoration: InputDecoration(labelText: 'Número máximo de participantes'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _equipmentController,
              decoration: InputDecoration(labelText: 'Equipamiento (separado por comas)'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: widget.brigade.status,
              items: ['Activa', 'En espera', 'Finalizada']
                  .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  widget.brigade.status = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Estado de la brigada'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Aquí iría la lógica para guardar los cambios
                widget.brigade.name = _nameController.text;
                widget.brigade.description = _descriptionController.text;
                widget.brigade.maxParticipants = int.tryParse(_maxParticipantsController.text) ?? widget.brigade.maxParticipants;
                widget.brigade.equipment = _equipmentController.text.split(',').map((e) => e.trim()).toList();
                MockBrigadeService.updateBrigade(widget.brigade);
                Navigator.pop(context);
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _maxParticipantsController.dispose();
    _equipmentController.dispose();
    super.dispose();
  }
}

// Pantalla de Chat de Brigada
class BrigadeChatScreen extends StatefulWidget {
  final String brigadeId;

  const BrigadeChatScreen({Key? key, required this.brigadeId}) : super(key: key);

  @override
  _BrigadeChatScreenState createState() => _BrigadeChatScreenState();
}

class _BrigadeChatScreenState extends State<BrigadeChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<String> _messages;

  @override
  void initState() {
    super.initState();
    _messages = MockBrigadeService.getMockMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat de Brigada'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                  leading: Icon(Icons.person),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add("Tú: ${_messageController.text}");
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}