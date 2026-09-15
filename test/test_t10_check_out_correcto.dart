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

  hotel.reservarHabitacion(
    huesped: huesped,
    numeroHabitacion: 101,
    diasEstadia: 3,
  );
  hotel.hacerCheckIn(numeroHabitacion: 101, cantidadPersonas: 2);
  hotel.hacerCheckOut(101);

  if (hab.estado == estadoHabitacion.disponible) {
    print("Prueba T10 Exitosa: Check-out correcto");
  } else {
    print("Error en T10");
  }
}
