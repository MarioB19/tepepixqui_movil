import 'package:cloud_firestore/cloud_firestore.dart';

class OngModel {
  String uid;
  Timestamp fechaSolicitud;
  String username;
  String tiempoFuncionamiento;
  String correoElectronico;
  String telefono;
  String nombreRepresentante;
  String cantidadPersonas;
  String nivelOperativo;
  String descripcionActividades;
  String cartaNotariadaPDF;
  String solicitud;

  OngModel({
    this.uid = '',
    this.solicitud = "Pendiente",
    required this.fechaSolicitud,
    required this.username,
    required this.tiempoFuncionamiento,
    required this.correoElectronico,
    required this.telefono,
    required this.nombreRepresentante,
    required this.cantidadPersonas,
    required this.nivelOperativo,
    required this.descripcionActividades,
    required this.cartaNotariadaPDF,
  });

  static FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> save() async {
    if (uid.isEmpty) {
      uid = db.collection('ong').doc().id;
    }
    await db.collection('ong').doc(uid).set(toFirestore());
  }

  Future<void> delete() async {
    if (uid.isNotEmpty) {
      await db.collection('ong').doc(uid).delete();
    }
  }

  static Future<OngModel?> getById(String uid) async {
    DocumentSnapshot doc = await db.collection('ong').doc(uid).get();
    if (doc.exists) {
      return OngModel.fromFirestore(doc);
    }
    return null;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fechaSolicitud': fechaSolicitud,
     
      'username': username,
      'tiempoFuncionamiento': tiempoFuncionamiento,
      'correoElectronico': correoElectronico,
      'telefono': telefono,
      'nombreRepresentante': nombreRepresentante,
      'cantidadPersonas': cantidadPersonas,
      'nivelOperativo': nivelOperativo,
      'descripcionActividades': descripcionActividades,
      'cartaNotariadaPDF': cartaNotariadaPDF,
      'solicitud' : solicitud,
    };
  }

  static OngModel fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return OngModel(
      uid: doc.id,
      fechaSolicitud: data['fechaSolicitud'],
    
      username: data['username'],
      tiempoFuncionamiento: data['tiempoFuncionamiento'],
      correoElectronico: data['correoElectronico'],
      telefono: data['telefono'],
      nombreRepresentante: data['nombreRepresentante'],
      cantidadPersonas: data['cantidadPersonas'],
      nivelOperativo: data['nivelOperativo'],
      descripcionActividades: data['descripcionActividades'],
      cartaNotariadaPDF: data['cartaNotariadaPDF'],
      solicitud: data['solicitud']
    );
  }
}
