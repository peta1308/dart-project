import 'reserva.dart';

class CheckIn {
  Reserva reserva;
  final int cantidadPersonas;
  final DateTime fechaEntrada;

  CheckIn({
    required this.reserva,
    required this.cantidadPersonas,
    required DateTime? fechaEntrada,
  }) : fechaEntrada = fechaEntrada ?? DateTime.now();
}
