import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tepepixqui_movil/models/ong_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OngPerfilIndex extends StatefulWidget {
  final String ongId;

  OngPerfilIndex({required this.ongId});

  @override
  _OngPerfilIndexState createState() => _OngPerfilIndexState();
}

class _OngPerfilIndexState extends State<OngPerfilIndex> {
  OngModel? ong;
  bool isLoading = true;
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cargarDatosOng();
  }

  Future<void> _cargarDatosOng() async {
    OngModel? ongCargada = await OngModel.getById(widget.ongId);
    setState(() {
      ong = ongCargada;
      isLoading = false;
    });
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> _guardarCambios() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await ong!.save();
      _toggleEditing();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cambios guardados correctamente')),
      );
    }
  }

  Future<void> _lanzarURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de ONG'),
        actions: [
          if (ong != null)
            IconButton(
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              onPressed: isEditing ? _guardarCambios : _toggleEditing,
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
                        Icon(
                          Icons
                              .person, // Puedes cambiar el ícono por el que necesites
                        ),
                        SizedBox(width: 8), // Espacio entre el ícono y el texto
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
                    _buildTextField('Nombre de usuario', ong!.username,
                        (value) => ong!.username = value),
                    _buildTextField(
                        'Tiempo de funcionamiento',
                        ong!.tiempoFuncionamiento,
                        (value) => ong!.tiempoFuncionamiento = value),
                    _buildTextField(
                        'Correo electrónico',
                        ong!.correoElectronico,
                        (value) => ong!.correoElectronico = value),
                    _buildTextField('Teléfono', ong!.telefono,
                        (value) => ong!.telefono = value),
                    _buildTextField(
                        'Nombre del representante',
                        ong!.nombreRepresentante,
                        (value) => ong!.nombreRepresentante = value),
                    _buildTextField(
                        'Cantidad de personas',
                        ong!.cantidadPersonas,
                        (value) => ong!.cantidadPersonas = value),
                    _buildTextField('Nivel operativo', ong!.nivelOperativo,
                        (value) => ong!.nivelOperativo = value),
                    _buildTextField(
                        'Descripción de actividades',
                        ong!.descripcionActividades,
                        (value) => ong!.descripcionActividades = value,
                        maxLines: 3),
                    SizedBox(height: 24),
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
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
    );
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
}
