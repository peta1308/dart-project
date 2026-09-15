import '../enums/estado_habitacion.dart';
import '../enums/tipo_habitacion.dart';

class Habitacion {
  estadoHabitacion estado;
  TipoHabitacion tipo;
  final int numero;
  final int capacidad;
  final double precioPorNoche;

  Habitacion({
    required this.numero,
    required this.tipo,
    required this.capacidad,
    required this.precioPorNoche,
    this.estado = estadoHabitacion.disponible,
  });
}
