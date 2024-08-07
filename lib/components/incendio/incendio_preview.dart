import 'package:flutter/material.dart';
import 'package:tepepixqui_movil/models/incendio.dart';
import 'package:intl/intl.dart';

class IncendioPreview extends StatelessWidget {
  final IncendioModel incendio;
  final Function() onToggleStatus;

  const IncendioPreview({
    Key? key,
    required this.incendio,
    required this.onToggleStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (incendio.fotografias.isNotEmpty)
            Image.network(
              incendio.fotografias[0],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fecha de inicio: ${DateFormat('dd/MM/yyyy HH:mm').format(incendio.fechaInicio)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Intensidad: ${incendio.intensidad}'),
                SizedBox(height: 8),
                Text(
                  'Descripción:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(incendio.descripcion),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onToggleStatus,
                  child: Text(incendio.activo ? 'Marcar como Pasado' : 'Reactivar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}