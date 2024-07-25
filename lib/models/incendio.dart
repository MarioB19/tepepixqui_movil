import 'package:cloud_firestore/cloud_firestore.dart';

class Incendio {
  String id; // Firestore document ID
  String ubicacion;
  DateTime fechaInicio;
  Duration duracion;
  double tamanoAproximado;
  String tipoVegetacion;
  String intensidad;
  String colorDelHumo;
  List<String> fotografias; // URLs or paths to images

  // Condiciones Meteorológicas
  String viento;
  double? temperatura;
  String humedad;

  Incendio({
    required this.id,
    required this.ubicacion,
    required this.fechaInicio,
    required this.duracion,
    required this.tamanoAproximado,
    required this.tipoVegetacion,
    required this.intensidad,
    required this.colorDelHumo,
    required this.fotografias,
    required this.viento,
    this.temperatura,
    required this.humedad,
  });

  // Convert object to map
  Map<String, dynamic> toMap() {
    return {
      'ubicacion': ubicacion,
      'fechaInicio': fechaInicio.toIso8601String(),
      'duracion': duracion.inHours,
      'tamanoAproximado': tamanoAproximado,
      'tipoVegetacion': tipoVegetacion,
      'intensidad': intensidad,
      'colorDelHumo': colorDelHumo,
      'fotografias': fotografias,
      'viento': viento,
      'temperatura': temperatura,
      'humedad': humedad,
    };
  }

  // Create object from map
  factory Incendio.fromMap(String id, Map<String, dynamic> map) {
    return Incendio(
      id: id,
      ubicacion: map['ubicacion'],
      fechaInicio: DateTime.parse(map['fechaInicio']),
      duracion: Duration(hours: map['duracion']),
      tamanoAproximado: map['tamanoAproximado'],
      tipoVegetacion: map['tipoVegetacion'],
      intensidad: map['intensidad'],
      colorDelHumo: map['colorDelHumo'],
      fotografias: List<String>.from(map['fotografias']),
      viento: map['viento'],
      temperatura: map['temperatura'],
      humedad: map['humedad'],
    );
  }

  // CRUD Operations
  // Create
  Future<void> create() async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('incendios').add(toMap());
    this.id = docRef.id;
  }

  // Read
  static Future<Incendio?> read(String id) async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('incendios').doc(id).get();
    if (docSnap.exists) {
      return Incendio.fromMap(docSnap.id, docSnap.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update
  Future<void> update() async {
    await FirebaseFirestore.instance.collection('incendios').doc(id).update(toMap());
  }

  // Delete
  Future<void> delete() async {
    await FirebaseFirestore.instance.collection('incendios').doc(id).delete();
  }
}
