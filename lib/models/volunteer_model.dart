import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  String uidVoluntario;
  Timestamp fechaCreacion;
  String provedor;
  String nombre;
  String apellidos;
  String correoElectronico;
  String telefono;
  String username;
  String fechaNacimiento;


  VolunteerModel({
    required this.uidVoluntario,
    required this.fechaCreacion,
    required this.provedor,
    required this.nombre,
    required this.apellidos,
    required this.correoElectronico,
    required this.telefono,
    required this.username,
    required this.fechaNacimiento,
  });

  static FirebaseFirestore db = FirebaseFirestore.instance;

  // Método para crear o actualizar un voluntario
  Future<void> save() async {
    await db.collection('voluntario').doc(uidVoluntario).set(toFirestore());
  }

  // Método para eliminar un voluntario
  Future<void> delete() async {
    await db.collection('voluntario').doc(uidVoluntario).delete();
  }

  // Método para leer un voluntario por UID
  static Future<VolunteerModel?> getById(String uidVoluntario) async {
    DocumentSnapshot doc =
        await db.collection('voluntario').doc(uidVoluntario).get();
    if (doc.exists) {
      return VolunteerModel.fromFirestore(doc);
    }
    return null;
  }

  // Serializa la información del voluntario para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uidVoluntario': uidVoluntario,
      'fechaCreacion': fechaCreacion,
      'provedor': provedor,
      'nombre': nombre,
      'apellidos': apellidos,
      'correoElectronico': correoElectronico,
      'telefono': telefono,
      'username': username,
      'fechaNacimiento': fechaNacimiento,
      
    };
  }

  // Deserializa la información de Firestore a un objeto VolunteerModel
  static VolunteerModel fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return VolunteerModel(
      uidVoluntario: doc.id,
      fechaCreacion: data['fechaCreacion'],
      provedor: data['provedor'],
      nombre: data['nombre'],
      apellidos: data['apellidos'],
      correoElectronico: data['correoElectronico'],
      telefono: data['telefono'],
      username: data['username'],
      fechaNacimiento: data['fechaNacimiento'],
    );
  }
}
