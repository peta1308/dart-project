import 'package:test/test.dart';
import 'package:hotel_cartagena_mod_reservas/services/hotel.dart';
import 'package:hotel_cartagena_mod_reservas/models/habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/models/huesped.dart';
import 'package:hotel_cartagena_mod_reservas/enums/estado_habitacion.dart';
import 'package:hotel_cartagena_mod_reservas/enums/tipo_habitacion.dart';

void main() {
  test('T07 - Reserva no disponible', () {
    var hab = Habitacion(
      numero: 101,
      tipo: TipoHabitacion.individual,
      capacidad: 2,
      precioPorNoche: 50.0,
      estado: estadoHabitacion.reservada,
    );
    var hotel = Hotel(habitacionesIniciales: [hab]);
    var huesped = Huesped('123', 'Emanuel');

    expect(
      () => hotel.reservarHabitacion(
        huesped: huesped,
        numeroHabitacion: 101,
        diasEstadia: 2,
      ),
      throwsA(isA<HotelException>()),
    );
  });
}
