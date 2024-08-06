import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class IncendioModel {
  String id; // Firestore document ID
  double ubicacionLatitud;
  double ubicacionLongitud;
  DateTime fechaInicio;
  String duracion;
  String tipoVegetacion;
  String intensidad;
  String colorDelHumo;
  List<String> fotografias; // URLs or paths to images

  bool activo;

  // Condiciones Meteorológicas
  String viento;
  String temperatura;
  String humedad;

  IncendioModel({
    this.id = '',
    required this.ubicacionLatitud,
    required this.ubicacionLongitud,
    required this.fechaInicio,
    required this.duracion,
    required this.tipoVegetacion,
    required this.intensidad,
    required this.colorDelHumo,
    required this.fotografias,
    required this.viento,
    required this.temperatura,
    required this.humedad,
     this.activo = true,
  });

  // Convert object to map
  Map<String, dynamic> toMap() {
    return {
      'ubicacionLatitud': ubicacionLatitud,
      'ubicacionLongitud': ubicacionLongitud,
      'fechaInicio': fechaInicio.toIso8601String(),
      'duracion': duracion,
      'tipoVegetacion': tipoVegetacion,
      'intensidad': intensidad,
      'colorDelHumo': colorDelHumo,
      'fotografias': fotografias,
      'viento': viento,
      'temperatura': temperatura,
      'humedad': humedad,
      'activo' : activo,
    };
  }

  // Create object from map
  factory IncendioModel.fromMap(String id, Map<String, dynamic> map) {
    return IncendioModel(
      id: id,
      ubicacionLatitud: map['ubicacionLatitud'],
      ubicacionLongitud: map['ubicacionLongitud'],
      fechaInicio: DateTime.parse(map['fechaInicio']),
      duracion: map['duracion'],
      tipoVegetacion: map['tipoVegetacion'],
      intensidad: map['intensidad'],
      colorDelHumo: map['colorDelHumo'],
      fotografias: List<String>.from(map['fotografias']),
      viento: map['viento'],
      temperatura: map['temperatura'],
      humedad: map['humedad'],
      activo: map ['activo']
    );
  }

  // CRUD Operations
  // Create
  Future<void> create() async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('incendios').add(toMap());
    this.id = docRef.id;
  }

  // Read
  static Future<IncendioModel?> read(String id) async {
    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection('incendios').doc(id).get();
    if (docSnap.exists) {
      return IncendioModel.fromMap(
          docSnap.id, docSnap.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update
  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection('incendios')
        .doc(id)
        .update(toMap());
  }

  // Delete
  Future<void> delete() async {
    await FirebaseFirestore.instance.collection('incendios').doc(id).delete();
  }
}
