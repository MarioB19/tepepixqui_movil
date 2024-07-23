import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginQuerys {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> checkIfFieldExists(String nameField, String field) async {
    try {
      // Crea dos consultas paralelas para verificar en ambas colecciones
      final volunteerQuery = _firestore
          .collection('voluntario')
          .where(nameField, isEqualTo: field)
          .limit(1)
          .get();
      final ongQuery = _firestore
          .collection('ong')
          .where(nameField, isEqualTo: field)
          .limit(1)
          .get();

      final results = await Future.wait([volunteerQuery, ongQuery]);

      bool volunteerExists = results[0].docs.isNotEmpty;
      bool ongExists = results[1].docs.isNotEmpty;

      return volunteerExists || ongExists;
    } catch (e) {
      print('Error checking if email exists: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> signInWithUsernameOrEmail(
      String identifier, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    String email = identifier;
    String userType = '';
    bool loginStatus = false;
    String messageError = "";

    try {
      if (identifier.contains('@')) {
        // Intentar iniciar sesión con correo electrónico
        await auth.signInWithEmailAndPassword(email: email, password: password);

        // Verificar el tipo de usuario después de iniciar sesión
        User? user = auth.currentUser;
        if (user != null) {
          // Verificar si el usuario es voluntario
          QuerySnapshot volunteerSnapshot = await firestore
              .collection('voluntario')
              .where('correoElectronico', isEqualTo: email)
              .get();

          if (volunteerSnapshot.docs.isNotEmpty) {
            userType = 'voluntario';
          } else {
            // Verificar si el usuario es ONG
            QuerySnapshot ongSnapshot = await firestore
                .collection('ong')
                .where('correoElectronico', isEqualTo: email)
                .get();

            if (ongSnapshot.docs.isNotEmpty) {
              userType = 'ong';

              if (ongSnapshot.docs.first['solicitud'] == "Pendiente") {
                throw Exception("La ONG no ha sido aprobada");
              }
            } else {
              throw Exception("Usuario no encontrado");
            }
          }
        } else {
          throw Exception("Error desconocido al obtener usuario");
        }
      } else {
        // Intentar iniciar sesión con nombre de usuario
        QuerySnapshot volunteerSnapshot = await firestore
            .collection('voluntario')
            .where('username', isEqualTo: identifier)
            .get();

        if (volunteerSnapshot.docs.isNotEmpty) {
          userType = 'voluntario';
          email = volunteerSnapshot.docs.first['correoElectronico'];
        } else {
          QuerySnapshot ongSnapshot = await firestore
              .collection('ong')
              .where('username', isEqualTo: identifier)
              .get();

          if (ongSnapshot.docs.isNotEmpty) {
            userType = 'ong';
            email = ongSnapshot.docs.first['correoElectronico'];

            if (ongSnapshot.docs.first['solicitud'] == "Pendiente") {
              throw Exception("La ONG no ha sido aprobada");
            }
          } else {
            throw Exception("Usuario no encontrado");
          }
        }

        await auth.signInWithEmailAndPassword(email: email, password: password);
      }

      User? user = auth.currentUser;
      if (user != null && !user.emailVerified) {
        throw Exception("Falta que verifiques tu correo electrónico");
      }

      loginStatus = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        messageError = 'La cuenta aun no ha sido verificada';
      } else if (e.code == 'user-not-found') {
        messageError = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        messageError = 'La contraseña es incorrecta';
      } else {
        messageError = e.message ?? 'Error desconocido';
      }
      loginStatus = false;
    } catch (e) {
      if (e is Exception) {
        messageError = e.toString().replaceFirst('Exception: ', '');
      } else {
        messageError = 'Error: ${e.toString()}';
      }
      loginStatus = false;
    }

    return {
      'loginStatus': loginStatus,
      'userType': userType,
      'messageError': messageError
    };
  }

static  Future<void> signOutUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      print("Usuario desconectado exitosamente");
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }
}
