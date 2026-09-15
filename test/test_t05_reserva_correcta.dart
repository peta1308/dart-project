import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';
import 'package:hotel_cartagena_mod_reservas/models/habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/models/huesped.dart';
import 'package:hotel_cartagena_mod_reservas/enums/estado_habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/enums/tipo_habitacion.dart';

void main() {
  var hab = Habitacion(
    numero: 101,
    tipo: TipoHabitacion.individual,
    capacidad: 2,
    precioPorNoche: 50.0,
    estado: estadoHabitacion.disponible,
  );
  var hotel = Hotel(habitacionesIniciales: [hab]);
  var huesped = Huesped('123', 'Emanuel');

  var reserva = hotel.reservarHabitacion(
    huesped: huesped,
    numeroHabitacion: 101,
    diasEstadia: 3,
  );

  if (reserva.activa && hab.estado == estadoHabitacion.reservada) {
    print("Prueba T05 Exitosa: Reserva correcta");
  } else {
    print("Error en T05");
  }
}
