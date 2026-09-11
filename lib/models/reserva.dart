import 'habitacion.dart';
import 'huesped.dart';

class Reserva {
  final String id;
  final Huesped huesped;
  final Habitacion habitacion;
  final int diasEstadia;
  bool activa;

  Reserva({
    required this.id,
    required this.huesped,
    required this.habitacion,
    required this.diasEstadia,
    this.activa = false,
  });
}
