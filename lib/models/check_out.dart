import 'check_in.dart';

class CheckOut {
  final CheckIn checkIn;
  final DateTime fechaSalida;
  final double totalPagar;

  CheckOut({required this.checkIn, required DateTime? fechaSalida})
    : fechaSalida = fechaSalida ?? DateTime.now(),
      totalPagar =
          checkIn.reserva.diasEstadia *
          checkIn.reserva.habitacion.precioPorNoche;
}
