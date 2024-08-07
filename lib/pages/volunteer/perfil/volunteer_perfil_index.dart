import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tepepixqui_movil/models/volunteer_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerProfilePage extends StatefulWidget {
  final String volunteerId;

  VolunteerProfilePage({required this.volunteerId});

  @override
  _VolunteerProfilePageState createState() => _VolunteerProfilePageState();
}

class _VolunteerProfilePageState extends State<VolunteerProfilePage> {
  VolunteerModel? volunteer;
  bool isLoading = true;
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadVolunteerData();
  }

  Future<void> _loadVolunteerData() async {
    VolunteerModel? loadedVolunteer = await VolunteerModel.getById(widget.volunteerId);
    setState(() {
      volunteer = loadedVolunteer;
      isLoading = false;
    });
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await volunteer!.save();
      _toggleEditing();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cambios guardados correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Voluntario'),
        actions: [
          if (volunteer != null)
            IconButton(
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              onPressed: isEditing ? _saveChanges : _toggleEditing,
            ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Text(
                          'Información Personal',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildTextField('Nombre', volunteer!.nombre,
                        (value) => volunteer!.nombre = value),
                    _buildTextField('Apellidos', volunteer!.apellidos,
                        (value) => volunteer!.apellidos = value),
                    _buildTextField('Nombre de usuario', volunteer!.username,
                        (value) => volunteer!.username = value),
                    _buildTextField('Correo electrónico', volunteer!.correoElectronico,
                        (value) => volunteer!.correoElectronico = value),
                    _buildTextField('Teléfono', volunteer!.telefono,
                        (value) => volunteer!.telefono = value),
                    _buildDateField('Fecha de Nacimiento', volunteer!.fechaNacimiento,
                        (value) => volunteer!.fechaNacimiento = value),
                    _buildSwitchField('Verificado como Brigadista', volunteer!.verificadoBrigadista,
                        (value) => volunteer!.verificadoBrigadista = value),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(width: 8),
                        Text(
                          'Información Adicional',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    _buildReadOnlyField('Fecha de Creación', 
                        DateFormat('dd/MM/yyyy').format(volunteer!.fechaCreacion.toDate())),

                          Row(
                      children: [
                        Icon(
                          Icons.link,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Enlaces',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _lanzarURL('https://tepepixqui.vercel.app/'),
                      icon: Icon(Icons.web),
                      label: Text('Visitar página web oficial'),
                    ),

                  ],
                ),
              ),
            ),
    );
  }

    Future<void> _lanzarURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }


  Widget _buildTextField(
      String label, String initialValue, Function(String) onSaved,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        maxLines: maxLines,
        enabled: isEditing,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          return null;
        },
        onSaved: (value) => onSaved(value!),
      ),
    );
  }

  Widget _buildDateField(
      String label, String initialValue, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        enabled: isEditing,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          return null;
        },
        onSaved: (value) => onSaved(value!),
        onTap: isEditing
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  onSaved(formattedDate);
                  setState(() {});
                }
              }
            : null,
      ),
    );
  }

  Widget _buildSwitchField(
      String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Switch(
            value: value,
            onChanged: isEditing ? onChanged : null,
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        enabled: false,
      ),
    );
  }
}